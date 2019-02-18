## GitLab configuration settings
##! This file is generated during initial installation and **is not** modified
##! during upgrades.
##! Check out the latest version of this file to know about the different
##! settings that can be configured by this file, which may be found at:
##! https://gitlab.com/gitlab-org/omnibus-gitlab/raw/master/files/gitlab-config-template/gitlab.rb.template


## GitLab URL
##! URL on which GitLab will be reachable.
##! For more details on configuring external_url see:
##! https://docs.gitlab.com/omnibus/settings/configuration.html#configuring-the-external-url-for-gitlab
external_url 'https://example.org'

### LDAP Settings
###! Docs: https://docs.gitlab.com/omnibus/settings/ldap.html
###! **Be careful not to break the indentation in the ldap_servers block. It is
###!   in yaml format and the spaces must be retained. Using tabs will not work.**

gitlab_rails['ldap_enabled'] = true

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
   main: # 'main' is the GitLab 'provider ID' of this LDAP server
     label: 'LDAP'
     host: 'host.docker.internal' # this is another docker container
     port: 10389
     uid: 'uid'
     bind_dn: 'cn=Directory Manager'
     password: 'password'
     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
#     verify_certificates: true
     active_directory: false
     allow_username_or_email_login: true
     lowercase_usernames: true
     block_auto_created_users: false
     base: 'ou=People,dc=example,dc=edu'
     user_filter: '(objectClass=inetUser)'
     ## EE only
#     group_base: ''
#     admin_group: ''
#     sync_ssh_keys: false
EOS

### OmniAuth Settings
###! Docs: https://docs.gitlab.com/ce/integration/omniauth.html
gitlab_rails['omniauth_enabled'] = true
gitlab_rails['omniauth_allow_single_sign_on'] = ['saml']
gitlab_rails['omniauth_sync_email_from_provider'] = 'saml'
gitlab_rails['omniauth_sync_profile_from_provider'] = ['saml']
gitlab_rails['omniauth_sync_profile_attributes'] = ['email']

# Auto sign-on would take you straight to CAS login page
#gitlab_rails['omniauth_auto_sign_in_with_provider'] = 'saml'

gitlab_rails['omniauth_block_auto_created_users'] = false


#gitlab_rails['omniauth_auto_link_ldap_user'] = true

# omniauth_auto_link_saml_user will link LDAP users with SAML users if LDAP user logged in first and e-mails match
gitlab_rails['omniauth_auto_link_saml_user'] = true
# gitlab_rails['omniauth_external_providers'] = ['twitter', 'google_oauth2']

# generate sha1 cert fingerprint from IDP signing certificate (e.g. CAS) with this:
# openssl x509 -noout -fingerprint -sha1 -inform pem -in /c/etc/cas/saml/idp-signing.crt
# SHA1 Fingerprint=2F:AE:D2:01:F0:4D:DF:33:61:DF:39:E1:76:57:2E:15:EA:B5:7D:6C

# name_identifier_format updated from persistent to transient per CAS metadata
gitlab_rails['omniauth_providers'] = [
   {
     "name" => "saml",
     "args" => {
        "assertion_consumer_service_url" => 'https://example.org/users/auth/saml/callback',
        "idp_cert_fingerprint" => '64:51:40:35:78:DC:83:89:69:DD:69:19:26:26:BB:6E:72:D3:0C:27',
        "idp_sso_target_url" => 'https://example.org/cas/idp/profile/SAML2/Redirect/SSO',
        "issuer" => 'https://example.org',
        "name_identifier_format" => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient',
        "allowed_clock_drift" => 360
      },
      "label" => "CAS Login"
   }
]

################################################################################
## GitLab NGINX
##! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html
################################################################################

# nginx['enable'] = true

##! Most root CA's are included by default
# nginx['ssl_client_certificate'] = "/etc/gitlab/ssl/ca.crt"

##! if ssl_verify_client on, verification depth in the client certificates chain
# nginx['ssl_verify_depth'] = "1"

# create this key/cert pair with the docker/gitlab/gencert.sh script prior to runnning the container
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.key"
letsencrypt['enable'] = false