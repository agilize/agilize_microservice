serve:
	@docker-compose -f ./docker-compose.yml -f ./docker-compose.dev.yml up
setup-laravel-project:
    # clone
    # middleware de data-map
    # middleware de SSO
    # centralizacao de log (correlationId, datadog, splunk, logstash+beats)
    # Monitoramento (https://kiali.io/, helm)
    # RabbitMQ
    # CI/CD
    # Postgres
