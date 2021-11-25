remedy_env_vars = Setting.find_by(name: 'remedy_env_vars')
remedy_env_vars.state = {
  access_token:  ENV['ACCESS_TOKEN'],
  base_url:      'https://tst-api-piemonte.ecosis.csi.it/tecno/troubleticketing/v1',
  request_id:    'zammad_to_remedy',
  forwarded_for: '127.0.0.1'
}
remedy_env_vars.save!

classification_engine_api_url = Setting.find_by(name: 'classification_engine_api_settings')
classification_engine_api_url.state = 'http://ts-ap1-be-bot-nextcrm.site02.nivolapiemonte.it/mlflow/mailclasstributi'
classification_engine_api_url.save!

chat_bot_api_url = Setting.find_by(name: 'chat_bot_api_settings')
chat_bot_api_url.state = 'http://ts-ap1-be-bot-nextcrm.site02.nivolapiemonte.it/botplat/example'
chat_bot_api_url.save!

saml_settings = Setting.find_by(name: 'auth_advanced_saml_credentials')
saml_settings.state = {
  idp_sso_target_url:             'https://tst-intranet.csi.it/iamidpcsi/profile/SAML2/Redirect/SSO',
  idp_cert:                       '-----BEGIN CERTIFICATE----- MIIEHDCCAwSgAwIBAgIJAOXHbpc+h3YlMA0GCSqGSIb3DQEBCwUAMIGvMQswCQYDVQQGEwJJVDER MA8GA1UECAwIUGllbW9udGUxDzANBgNVBAcMBlRvcmlubzEVMBMGA1UECgwMQ1NJIFBpZW1vbnRl MSQwIgYDVQQLDBtDZW50cm8gVGVjbmljbyBDU0kgUGllbW9udGUxFjAUBgNVBAMMDXNoaWJib2xl dGhJRFAxJzAlBgkqhkiG9w0BCQEWGGlkZW50aXRhLmRpZ2l0YWxlQGNzaS5pdDAeFw0xNjAyMDEx MTEzNDRaFw0zNjAxMjcxMTEzNDRaMIGvMQswCQYDVQQGEwJJVDERMA8GA1UECAwIUGllbW9udGUx DzANBgNVBAcMBlRvcmlubzEVMBMGA1UECgwMQ1NJIFBpZW1vbnRlMSQwIgYDVQQLDBtDZW50cm8g VGVjbmljbyBDU0kgUGllbW9udGUxFjAUBgNVBAMMDXNoaWJib2xldGhJRFAxJzAlBgkqhkiG9w0B CQEWGGlkZW50aXRhLmRpZ2l0YWxlQGNzaS5pdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC ggEBAKvoTMFLyRIDsuV3EAUsknpM5TZj0sy3NT9STwSWcOLw5UgVfGFs+IE4uLYtqaxZ39N4qcu8 7cj7oN8myFILBEmWcjC2/l+APa8PpDVg/7AseDtVSAVw4wbLv4W0LzyAAxuuLYdM6r7+KUM72irn zYvPSpDFPIHA0JbEcP2EYtdrcU8q9L00AlIuE+5wQnRr4GaIfyDaeNtvH0Y7qmCcyxNgtjIOIdmX bWphCxZZGWlEPL5yTLEUiTS+dwlPxADvZzTSQEqrk953ziPKzwdpjp1tbmTDR0/cpzDI1RRKEXaQ thEXQNGeFi9MqVF0g4lI6KKxVvZNl6fPxog7m/ItQAcCAwEAAaM5MDcwCQYDVR0TBAIwADALBgNV HQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMA0GCSqGSIb3DQEBCwUAA4IB AQAAY+GMi8M4eRD0jD1mzaM5D74pIn8mOv7k8nmQRbZJiCFEuZFjlTNKt/1xt81xrkvRWbeOKFky 5cabWQBJDTmgIf55LW8kdbf+nZOR6afY439TLO0vAMlMFC/b7j3u0nig0u7idXAPgdZh4eqohUZH eXNLXOIPn8u3YxaUeFRQJ+uYO04f7OldRGTBZaMIzNXAbnzZvyvZNL7+qa5Oo8iKN8NPcC9p0yAd mfyiJROcVFPUeUO6HBP9PqksaZlUvfVVXKglwuIoR8bUqmqXBGblpHcFggj/W/y8VPmYuT8ahc1g AmPp1ztmSQ3VRf582+CDSu/yh+uVn541CviUXyhN -----END CERTIFICATE-----',
  idp_cert_fingerprint:           '',
  name_identifier_format:         '',
  issuer:                         'SERVICE_PROVIDER_TST-NEXTCRM.PREPROD.NIVOLAPIEMONTE.IT_LIV1_ICSI',
  private_key:                    '-----BEGIN RSA PRIVATE KEY----- MIIEpAIBAAKCAQEAwO7DwH6Ku5ePe1+pYGKCwgenbKvq2GOAUw8j5Eu4fYQg2zn3 7vmSqrv/W7jOv02TDjqjI6j5B4i67MfTSuMqCTXv3aBtN01AZqjPbTM4b4+FAp5Q Lj6CvFepxt4dTfW8xWnBGc4PsFJ5kacpmoSaGP803Dd6me4Y/rRt4sEMjdttsgbK YYYU7K8PEp9BSaLIJjngV/vGCfXH9g3HXJYc9WX//TTkPsWzfYIELfpm7EvTHqoq vfOo3TSS3KYiywvn5w65xC095CkhkEct5WhAoSsvpb7xKCvmrDkv/YWZy1kmMuJ9 GxJeXhqkkEbAytvZZ3x7qVhnufDLKTxKEWn/WQIDAQABAoIBAHsQEYbYcI+l5hyw 8S4MyBERpsaXhk4Occ0JLECz1/Mf84FCoZYqVVZYYlLUN/QofDOoTWUyo94dZfYg o/LxoV+Mqvq4GNIckYaqCN1DvazTY+k+qDBHKUcPt7ik9xZCN+3IPibCnJlAklDI yq3IBS8KomIRdT94czMMTcdEkkhs4ijgPSYVXSKMcMfhP3XEqvhhUmZ/9GnRSqcJ PXIUITZsygh16RZSz8exxASouw7CWfuBFAgWECkH+r5u4f15hBe/GDxVFMuRD7HH LTsgN21mtYY3pLBnG1L5ILkpUGaUEELglhNKiZlVqxTN2zgjLhM3TgQ2rfh2eXYu 1Kb/hL0CgYEA4WKGW2sJVIW0ndEcggo71T+sKrSzo1yprpUpPU5POLSzaPJHkeqT 1/p9nYW7MTEbmr2eENfiAIiJe1qzIImCpK6xuwVZMjnYzyBsiJeOqZ2aolk2jLvs QpTHCqnY0PqY/qyh/456PB8CxKHK9XEqWrDn6UbihC8AW22q1YvbpT8CgYEA2yPB e2YM7sxFbzbz7ZTa6e2/Vua15uJLvCUw3YqzN3MRM9IaZyFr7iytoE/M0OWshRa2 2KDl8wYtOKXhfd9DCR7bFmyWcaATS4349yST7SsNFtyqU2K9RQXP7hZB6vgsgCHk stpYskIinqdDJDP2DrvvvnMQfkapEXmJr1M1vWcCgYEAig6f3j+iZ3O/PyxoGf/K xsVJ4J7vqpGIHrifmj3tqP6HJzHBRVA7X4DAkUzpbSh3kEG2IPscJNd932Gfd77D l7yqgbS0/l8Qv09NLB4p9RvlLK0ZDPvPrLkVcyK2/MuEC/wS/0d2+HzGZUv11oKL PyI97FbPScjAn0B99HDHCmECgYBgTox/sM/KOtfhEqONLDgxSp0mkeoreBSUsTuS gZxVqCpNPe8Al/2ZBOWhaLC4tddl/h+JgNzOO06wcKZy7SXG4lqitkI/2XvhXpml 89tXBe6Qt5XbY6+OoAlLt1hs7XiRL1QVDkSgwtP4KcYmKPfgbdPlPShodqFi3qkV 9lnNzQKBgQCgArsWpY9FoE6w1benBwPcxLRO6Roqj9PAKCaLnFo1PK80ay19Mdw+ zRdLth84L6HrnOWeK20WvtufwaSJWdlmxt3gZJoD4I0Yl82afb8Kml9Ggnp34v4c Wde6Z9dAEMRpckXDuXLU+RyGK/QDr4mHe02ssOOj8z3hzfE9E8rxDg== -----END RSA PRIVATE KEY-----',
  assertion_consumer_service_url: ENV['ASSERTION_CONSUMER_SERVICE_URL']
}
saml_settings.save!

remedy_base_url = Setting.find_by(name: 'remedy_base_url')
remedy_base_url.state = 'https://tst-api-piemonte.ecosis.csi.it/tecno/troubleticketing/v1'
remedy_base_url.save!

remedy_token = Setting.find_by(name: 'remedy_token')
remedy_token.state = 'f9b12cd4-16f3-3956-96fa-2f288667b9f3'
remedy_token.save!

notification_sender_email = Setting.find_by(name: 'notification_sender')
notification_sender_email.state = 'Taylor CSI TEST <crmtest1@uctest.csi.it>'
notification_sender_email.save!
