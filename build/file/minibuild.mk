module_type = 'executable'

module_name = 'file'

definitions = ['HAVE_CONFIG_H']
definitions_windows = ['WIN32']

include_dir_list = [
  '../../include',
  '../../vendor',
  '../../vendor/compat/include',
]

src_search_dir_list = [
    '../../vendor/src',
]

lib_list = [
  '../static',
  '../db',
]

build_list = [
  'file.c'
]

if BUILDSYS_TOOLSET_NAME == 'msvs':
    build_list += ['getopt_long.c']
    definitions_windows += ['_CRT_SECURE_NO_WARNINGS', 'REPLACE_GETOPT']
    disabled_warnings = ['4267']
