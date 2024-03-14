#rule to grab all the results to a results folder
rule paired:
    input:
        assembly = os.path.join(dir_megahit, "{sample}-pr", "final.contigs.fa"),
        faa = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}.faa"), 
        fna = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}.fna"),
        gbff = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}.gbff"),
        gff3 = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}.gff3"),
        txt = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}.txt"),
        amr = os.path.join(dir_bakta_short, "{sample}_bakta", "{sample}_amrfinderplus"),
        pp_coord = os.path.join(dir_bakta_short, "{sample}_prophages", "{sample}_prophage_prophage_coordinates.tsv"),
        pp_gbff = os.path.join(dir_bakta_short, "{sample}_prophages", "{sample}_prophage_{sample}.gbff")
    output:
        os.path.join(dir_summary_short, "{sample}", "logs")
    params:
        summary_dir = os.path.join(dir_summary_short, "{sample}")
    shell:
        """
        cp {input.assembly} {params.summary_dir}
        cp {input.faa} {params.summary_dir}
        cp {input.fna} {params.summary_dir}
        cp {input.gbff} {params.summary_dir}
        cp {input.gff3} {params.summary_dir}
        cp {input.txt} {params.summary_dir}
        cp {input.amr} {params.summary_dir}
        cp {input.pp_coord} {params.summary_dir}
        cp {input.pp_gbff} {params.summary_dir}
        echo "DONE-GREAT-WORK" >{output}
        """

rule longreads:
    input:
        assembly = os.path.join(dir_hybracter, "hybracter.out", "final_assemblies", "{sample}_final.fasta"),
        faa = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}.faa"), 
        fna = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}.fna"),
        gbff = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}.gbff"),
        gff3 = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}.gff3"),
        txt = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}.txt"),
        amr = os.path.join(dir_bakta_long, "{sample}_bakta", "{sample}_amrfinderplus"),
        pp_coord = os.path.join(dir_bakta_long, "{sample}_prophages", "{sample}_prophage_prophage_coordinates.tsv"),
        pp_gbff = os.path.join(dir_bakta_long, "{sample}_prophages", "{sample}_prophage_{sample}.gbff")
    output:
        os.path.join(dir_summary_long, "{sample}", "log")
    params:
        summary_dir = os.path.join(dir_summary_long, "{sample}")
    shell:
        """
        cp {input.assembly} {params.summary_dir}
        cp {input.faa} {params.summary_dir}
        cp {input.fna} {params.summary_dir}
        cp {input.gbff} {params.summary_dir}
        cp {input.gff3} {params.summary_dir}
        cp {input.txt} {params.summary_dir}
        cp {input.amr} {params.summary_dir}
        cp {input.pp_coord} {params.summary_dir}
        cp {input.pp_gbff} {params.summary_dir}
        echo "DONE-GREAT-WORK" >{output}
        """