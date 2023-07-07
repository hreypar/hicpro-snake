#! /usr/bin/env python
# -*- coding utf-8 -*-

# function to determine if the curl command has special options or not
#
rule remote_download:
    """
    Downloads a remote file and checks the md5sum
    """
    conda:
        "../envs/remote_download.yaml"
    output:
        'resources/downloads/{file}'
    params:
        url = lambda wildcards: config['downloads'][wildcards.file]['url'],
        md5 = lambda wildcards: config['downloads'][wildcards.file]['md5']
    shell:
        '''
	curl -L {params.url} > {output}

        echo "{params.md5}  {output}" | md5sum -c -
        '''

