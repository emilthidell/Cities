<?php
namespace Cities\Mail;

use Phalcon\Mvc\User\Component;
use Swift_Message as Message;
use Swift_SmtpTransport as Smtp;
use Phalcon\Mvc\View;
use Mandrill;
/**
 * Cities\Mail\Mail
 * Sends e-mails based on pre-defined templates
 */
class Mail extends Component
{

    protected $transport;

    protected $amazonSes;

    protected $directSmtp = false;

    /**
     * Construct the Mail and check driver config
     *
     */
    public function __construct(){
        if(strtolower($this->config->mail->driver) == "smtp"){
            $this->directSmtp = true;
        }
    }

    /**
     * Send a raw e-mail via AmazonSES
     *
     * @param string $raw
     */
    private function amazonSESSend($raw)
    {
        if ($this->amazonSes == null) {
            $this->amazonSes = new \AmazonSES(
                $this->config->amazon->AWSAccessKeyId,
                $this->config->amazon->AWSSecretKey
            );
            $this->amazonSes->disable_ssl_verification();
        }

        $response = $this->amazonSes->send_raw_email(array(
            'Data' => base64_encode($raw)
        ), array(
            'curlopts' => array(
                CURLOPT_SSL_VERIFYHOST => 0,
                CURLOPT_SSL_VERIFYPEER => 0
            )
        ));

        if (!$response->isOK()) {
            throw new Exception('Error sending email from AWS SES: ' . $response->body->asXML());
        }

        return true;
    }

    /**
     * Applies a template to be used in the e-mail
     *
     * @param string $name
     * @param array $params
     */
    public function getTemplate($name, $params)
    {
        $parameters = array_merge(array(
            'publicUrl' => $this->config->application->publicUrl
        ), $params);

        return $this->view->getRender('emailTemplates', $name, $parameters, function ($view) {
            $view->setRenderLevel(View::LEVEL_LAYOUT);
        });

        return $view->getContent();
    }

    /**
     * Sends e-mails via AmazonSES or SMTP based on predefined templates
     *
     * @param array $to
     * @param string $subject
     * @param string $name
     * @param array $params
     */
    public function send($to, $subject, $name, $params)
    {
        // Settings
        $mailSettings = $this->config->mail;

        $template = $this->getTemplate($name, $params);
        $text     = trim(strip_tags($template));

        if(strtolower($mailSettings->driver) == "mandrill"){

            // Create the message
            $message = Message::newInstance()
                ->setSubject($subject)
                ->setTo($to)
                ->setFrom(array(
                    $mailSettings->fromEmail => $mailSettings->fromName
                ))
                ->setBody($template, 'text/html');

            try {
                $mandrill = new Mandrill($mailSettings->mandrill->apiKey);
                if(is_string($to)){
                    $to = array($to);
                }
                $newTo = array();
                foreach($to as $key=>$t){
                    if(strpos($t, '@')){
                        $newTo[] = $t;
                    }else if(strpos($key, '@')){
                        $newTo[] = $key;
                    }
                }

                if(count($newTo) === 0){
                    return false;
                }

                $message = array(
                    'raw_message' => $message->toString(),
                    'key' => $mailSettings->mandrill->apiKey,
                    'subject' => $subject,
                    'from_email' => $mailSettings->fromEmail,
                    'from_name' => $mailSettings->fromName,
                    'to' => $newTo,
                    'ip_pool' => 'Cities Pool',
                    'async'   => true,
                );

                $url = "/messages/send-raw";

                $result = $mandrill->call($url, $message);

                return true;
                
            } catch(Mandrill_Error $e) {
                // Mandrill errors are thrown as exceptions
                echo 'A mandrill error occurred: ' . get_class($e) . ' - ' . $e->getMessage();
                // A mandrill error occurred: Mandrill_Unknown_Subaccount - No subaccount exists with the id 'customer-123'
                throw $e;
            }
        }

        // Create the message
        $message = Message::newInstance()
            ->setSubject($subject)
            ->setTo($to)
            ->setFrom(array(
                $mailSettings->fromEmail => $mailSettings->fromName
            ))
            ->setBody($template, 'text/html');

        $headers = $message->getHeaders();


        if ($this->directSmtp) {

            if (!$this->transport) {
                $this->transport = Smtp::newInstance(
                    $mailSettings->smtp->server,
                    $mailSettings->smtp->port,
                    $mailSettings->smtp->security
                )
                ->setUsername($mailSettings->smtp->username)
                ->setPassword($mailSettings->smtp->password);
            }

            // Create the Mailer using your created Transport
            $mailer = \Swift_Mailer::newInstance($this->transport);

            return $mailer->send($message);
        } else {
            return $this->amazonSESSend($message->toString());
        }
    }
}
