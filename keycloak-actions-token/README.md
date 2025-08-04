# Keycloak actions token

This extension exposes a custom realm resource to manage action tokens in keycloak.

## Build the example
```
mvn clean verify
```

## Deploy the example
### Wildfly
Copy the `.jar` into the keycloak directory `standalone/deployments`
### Quarkus
Copy the `.jar` into the keycloak directory `providers`

## Routes

### Generate
#### Wildfly
```
POST /auth/realms/{realm}/actions-token/generate
```
#### Quarkus
```
POST /realms/{realm}/actions-token/generate
```

#### Description
Request an action token for a set of specific actions.

#### Request
| Type | Name | Required | Description | Schema |
| :----: | --- | --- | --- | --- |
| Path | realm | true | realm name (not id!) | string |
| Body | user_id | true | User that will be asked to perform a set of required actions | string |
| Body | actions | true | Required actions the user needs to complete. List of [required actions here](https://www.keycloak.org/docs-api/16.0/javadocs/org/keycloak/models/UserModel.RequiredAction.html) | < string > array |
| Body | lifespan | false | Number of seconds after which the generated token expires | integer(int32) |
| Body | client_id | false | OAuth client the token was issued for. Defaults to the `account` client. | string |
| Body | redirect_uri | false | If no redirect is given, then there will be no link back to click after actions have completed. Redirect uri must be a valid uri for the particular `client_id` | string |
| Body | redirect_uri_validate | false | Bypass `redirect_uri` validation checks for the particular `client_id` | boolean |
#### Response
| Type | Name | Required | Description | Schema |
| :----: | --- | --- | --- | --- |
| Body | action_token | true | JWT action token signed with the realm's default signature algorithm | string |
