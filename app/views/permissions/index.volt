
{{ content() }}

<form method="post">

<div class="well" align="center">

    <h2>Manage Permissions</h2>

    <table class="perms">
        <tr>
            <td><label for="profileId">Profile</label></td>
            <td>{{ select('profileId', profiles, 'using': ['id', 'name'], 'useEmpty': true, 'emptyText': '...', 'emptyValue': '') }}</td>
            <td>{{ submit_button('Search', 'class': 'btn btn-primary') }}</td>
        </tr>
    </table>

</div>

{% if request.isPost() and profile %}

<div class="well">

{% for resource, actions in acl.getResources() %}

    <h3>{{ resource }}</h3>

    <table class="table table-bordered table-striped" align="center">
        <thead>
            <tr>
                <th width="5%"></th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            {% for action in actions %}
            <tr>
                <td align="center"><input type="checkbox" name="permissions[]" value="{{ resource ~ '.' ~ action }}"  {% if permissions[resource ~ '.' ~ action] is defined %} checked="checked" {% endif %}></td>
                <td>{{ acl.getActionDescription(action) ~ ' ' ~ resource }}</td>
            </tr>
            {% endfor %}
        </tbody>
    </table>

{% endfor %}

</div>

{% endif %}

</form>
