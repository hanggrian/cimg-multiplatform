"""
Write Dockerfile to root with command 'python make_dockerfile.py platform1-version1 ...'
"""

from os import mkdir
from sys import argv

from requests import get

BASE_VERSION = "2024.02"
MAINTAINER_NAME = 'Hendra Anggrian'
MAINTAINER_EMAIL = 'hanggrian@proton.me'


def get_content(
    platform,
    version,
    branch='main',
    start_from='LABEL maintainer="CircleCI Execution Team <eng-execution@circleci.com>"\n',
):
    """Retrieve content from GitHub raw file."""
    url = \
        'https://github.com/CircleCI-Public/' + \
        f'cimg-{platform}/' + \
        f'raw/{branch}/' + \
        f'{version}/Dockerfile'
    response = get(url, timeout=5)
    response.raise_for_status()
    return url, response.text.split(start_from, 1)[1].replace('\t', '  ')


if __name__ == '__main__':
    dir_name = ''
    lines = \
        f'''
FROM cimg/base:{BASE_VERSION}

LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
'''
    comment_lines = \
        '''# A combination of:
#
'''

    for arg in argv[1:]:
        arr = arg.split('-')
        if len(arr) != 2:
            raise ValueError()
        dir_name += f'{arr[0]}{arr[1].split('.')[0]}-'
        path, content = get_content(arr[0], arr[1])
        lines += content
        comment_lines += f'# - {path}\n'

    dir_name = dir_name[:-1]
    mkdir(dir_name)
    with open(f'{dir_name}/Dockerfile', 'w', encoding='UTF-8') as file:
        file.write(comment_lines + lines)
