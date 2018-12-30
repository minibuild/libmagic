from __future__ import print_function
import argparse
import os.path
import subprocess

def assemble_binary_file(source_file, output):
    with open(source_file, mode='rb') as source:
        bin_data = source.read()
    output.write('static unsigned char LIBMAGIC_BUILTIN_DATA[] = {')
    for i in range(0, len(bin_data), 16):
        output.write('\n    ')
        for c in bin_data[i:i+16]:
            output.write('{: >3d}, '.format(ord(c)))
    output.write('\n};\n\n')
    return len(bin_data)


def libmagic_compile_db(compiler, objdir, inputdir, output):
    mgc_blob = os.path.join(objdir, os.path.basename(inputdir)) + '.mgc'
    subprocess.check_call([compiler, '-C', '-m', inputdir], cwd=objdir)
    if not os.path.isfile(mgc_blob):
        print('ERROR: Required file not found: {}'.format(mgc_blob))
        exit(1)
    with open(output, mode='w') as fh:
        fh.write('#include <stddef.h>\n\n')
        blob_size = assemble_binary_file(mgc_blob, fh)
        fh.write('size_t LIBMAGIC_BUILTIN_DB_SIZE = {};\n'.format(blob_size))
        fh.write('void* LIBMAGIC_BUILTIN_DB = LIBMAGIC_BUILTIN_DATA;\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--compiler', required=True)
    parser.add_argument('--objdir', required=True)
    parser.add_argument('--input', required=True)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()

    libmagic_compile_db(args.compiler, os.path.normpath(args.objdir), os.path.normpath(args.input), os.path.normpath(args.output))
