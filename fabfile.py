from fabric.api import env, run
import os


def production():
    env.host_string = os.environ['PRODUCTION_IP']
    env.user = 'ubuntu'


def deploy():
    run("docker-compose -f docker-compose.production.yml up -d")
