alias ls=' ls -G'
alias cd=' cd'
alias ssh='TERM=xterm-256color ssh'

nomad-se-dev() {
    NOMAD_SECRET=$(aws --region eu-central-1 secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:eu-central-1:962288559711:secret:jerry-se-nomad-cert-9ky-UON44L --query SecretString --output text)
    NOMAD_CACERT=~/.nomad/dev_se/ca_file \
        NOMAD_CLIENT_CERT=~/.nomad/dev_se/cert_file \
        NOMAD_CLIENT_KEY=~/.nomad/dev_se/key_file \
        NOMAD_ADDR=https://se-nomad-server-0.dev.cs42.net:4646 \
        nomad "$@"
}

nomad-se-prod() {
    NOMAD_CACERT=~/.nomad/prod_se/ca_file \
        NOMAD_CLIENT_CERT=~/.nomad/prod_se/cert_file \
        NOMAD_CLIENT_KEY=~/.nomad/prod_se/key_file \
        NOMAD_ADDR=https://se-nomad-server-0.prod.cs42.net:4646 \
        nomad "$@"
}

nomad-se-jerry() {
    NOMAD_CACERT=~/.nomad/jerry_se/ca_file \
        NOMAD_CLIENT_CERT=~/.nomad/jerry_se/cert_file \
        NOMAD_CLIENT_KEY=~/.nomad/jerry_se/key_file \
        NOMAD_ADDR=https://nomad-master-0.jerry-se.prod.binaryedge.io:4646 \
        nomad "$@"
}
