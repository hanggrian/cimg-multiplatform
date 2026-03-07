# Manual cleaning after generate:
#
# - Replace all 'https://dlcdn.apache.org/maven/maven-3/' with
#   'https://archive.apache.org/dist/maven/maven-3/'
# - Replace all 'http://apache.osuosl.org/maven/maven-3/' with
#   'https://archive.apache.org/dist/maven/maven-3/'

from os import makedirs
from textwrap import dedent

from colorama import Fore, Style
from requests import get, Response

BASE_VERSION: str = '2026.03'  # always latest
MAINTAINER_NAME: str = 'Hendra Anggrian'
MAINTAINER_EMAIL: str = 'hanggrian@proton.me'
TARGETS = (
    {
        'platform': 'openjdk',
        'versions': ['17.0', '21.0', '25.0'],
    },
    {
        'platform': 'android',
        'versions': ['2024.04', '2025.03', '2026.03'],
    },
    {
        'platform': 'python',
        'versions': ['3.13', '3.14'],
    },
)

# rebuild targets
new_targets = []
python = TARGETS[-1]
for target in TARGETS[:-1]:
    for python_version in python['versions']:
        for target_version in target['versions']:
            new_targets.append({
                'platform1': target['platform'],
                'version1': target_version,
                'platform2': python['platform'],
                'version2': python_version,
            })
TARGETS = tuple(new_targets)


def get_content(
    cimg_platform: str,
    cimg_version: str,
    dockerfile: str = 'Dockerfile',
):
    """Retrieve content from GitHub raw file."""
    url: str = \
        'https://github.com/CircleCI-Public/' + \
        f'cimg-{cimg_platform}/raw/' + \
        f'main/{cimg_version}/{dockerfile}'
    response: Response = get(url, timeout=6)
    response.raise_for_status()
    text: str = response.text.replace('\t', '  ')
    return url, text.split('@circleci.com>"\n', 1)[1]


if __name__ == '__main__':
    build_images_lines: str = \
        dedent(
            '''
            #!/usr/bin/env bash

            set -eo pipefail

            ''',
        ).lstrip()
    push_images_lines: str = \
        dedent(
            '''
            #!/usr/bin/env bash

            set -eo pipefail

            ''',
        ).lstrip()

    print(f'{Fore.YELLOW}Merging cimgs...{Style.RESET_ALL}')
    for target in TARGETS:
        platform1: str = target['platform1']
        platform2: str = target['platform2']
        version1: str = target['version1']
        version2: str = target['version2']
        print(f'- {platform1}-{version1} + {platform2}-{version2}')

        dockerfile_lines: str = \
            dedent(
                f'''
                FROM cimg/base:{BASE_VERSION}

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        dockerfile_comments: str = \
            dedent(
                '''
                # A combination of:
                #
                ''',
            ).lstrip()

        # standard images
        path, content = get_content(platform1, version1)
        dockerfile_lines += content
        dockerfile_comments += f'# - {path}\n'
        path, content = get_content(platform2, version2)
        dockerfile_lines += content
        dockerfile_comments += f'# - {path}\n'

        dir_name: str = platform1 + version1 + '-' + platform2 + version2
        makedirs(dir_name, exist_ok=True)
        with open(f'{dir_name}/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_lines)

        # node images are built on standard images
        dockerfile_node_lines: str = \
            dedent(
                f'''
                FROM hanggrian/cimg-multiplatform:{dir_name}

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        _, content = get_content(platform2, version2, 'node/Dockerfile')
        dockerfile_node_lines += content
        makedirs(f'{dir_name}/node', exist_ok=True)
        with open(f'{dir_name}/node/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_node_lines)

        # browser images are built on standard images
        dockerfile_browsers_lines: str = \
            dedent(
                f'''
                FROM hanggrian/cimg-multiplatform:{dir_name}-node

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        _, content = get_content(platform2, version2, 'browsers/Dockerfile')
        dockerfile_browsers_lines += content
        makedirs(f'{dir_name}/browsers', exist_ok=True)
        with open(f'{dir_name}/browsers/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_browsers_lines)

        # create shell scripts
        build_images_lines += \
            dedent(
                f'''
                docker build --file {dir_name}/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name} --platform linux/amd64 .
                docker build --file {dir_name}/node/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name}-node --platform linux/amd64 .
                docker build --file {dir_name}/browsers/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name}-browsers --platform linux/amd64 .

                ''',
            ).lstrip()
        push_images_lines += \
            dedent(
                f'''
                docker push hanggrian/cimg-multiplatform:{dir_name}
                docker push hanggrian/cimg-multiplatform:{dir_name}-node
                docker push hanggrian/cimg-multiplatform:{dir_name}-browsers

                ''',
            ).lstrip()

    print(f'{Fore.YELLOW}Creating shell scripts...{Style.RESET_ALL}')
    with open('build_images.sh', 'w', encoding='UTF-8') as file:
        file.write(build_images_lines)
    with open('push_images.sh', 'w', encoding='UTF-8') as file:
        file.write(push_images_lines)

    print(f'{Fore.GREEN}Done.{Style.RESET_ALL}')
    print()
    print('Goodbye!')
