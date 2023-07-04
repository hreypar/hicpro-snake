#! /usr/bin/env python
# -*- coding utf-8 -*-

rule install_hicpro:
    """
    Decompress HiC-Pro tar gz and then install
    because it is not available in conda
    """
    conda:
        "../envs/hicpro.yaml"
    output:
        config['hicpro']['software_bin']
    input:
        config['software']['hicpro_targz']
    params:
        outdir = config['hicpro']['software_dir'],
        idir = config['local_tmp']

    shell:
        '''
        mkdir -p {output}
        
        tar\
        --extract\
        -z\
        --verbose\
        --file {input}\
        -C {params.outdir}\
        --strip-components=1

        # this is actually repulsive
        cd {params.outdir}

        install_dir={params.idir}
        sed -i "s|PREFIX = .*|PREFIX = $install_dir|" config-install.txt

        make configure
        make install
        '''

