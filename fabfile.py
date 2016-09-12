from fabric.api import env, run


def production():
    env.host_string = "54.171.218.135"
    env.user = 'ubuntu'


def deploy():
    run("docker-compose -f docker-compose.production.yml up -d")
