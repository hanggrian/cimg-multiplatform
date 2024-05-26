"""
Write Dockerfile to root with command 'python make_dockerfile.py platform1:version1 ...'
"""

from sys import argv

from requests import get

BASE_VERSION = "2024.02"
MAINTAINER_NAME = 'Hendra Anggrian'
MAINTAINER_EMAIL = 'hendraanggrian@gmail.com'


def get_dockerfile_content(
    platform,
    version,
    branch='main',
    start_from='LABEL maintainer="CircleCI Execution Team <eng-execution@circleci.com>"\n',
):
    url = \
        'https://github.com/CircleCI-Public/' + \
        f'cimg-{platform}/' + \
        f'raw/{branch}/' + \
        f'{version}/Dockerfile'
    response = get(url, timeout=5)
    response.raise_for_status()
    return url, response.text.split(start_from, 1)[1].replace('\t', '  ')


if __name__ == '__main__':
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
        content = get_dockerfile_content(arr[0], arr[1])
        lines += content[1]
        comment_lines += f'# - {content[0]}\n'

    with open('Dockerfile', 'w', encoding='UTF-8') as file:
        file.write(comment_lines + lines)
