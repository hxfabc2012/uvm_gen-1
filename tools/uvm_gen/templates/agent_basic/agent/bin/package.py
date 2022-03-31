# Copyright ${year} ${name_of_copyright_owner}
# ${license}
########################################################################################################################


import tarfile
import os.path

def make_tarfile(output_filename, source_dir):
    with tarfile.open(output_filename, "w:gz") as tar:
        tar.add(source_dir, arcname=os.path.basename(source_dir))

make_tarfile("uvma_${name}_pkg.tgz", "../"")
