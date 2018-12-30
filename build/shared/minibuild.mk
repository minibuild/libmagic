module_type = 'lib-shared'

if BUILDSYS_TARGET_PLATFORM == 'windows':
    module_name = 'libmagic'
else:
    module_name = 'magic'

export = [
  'magic_open',
  'magic_close',
  'magic_file',
  'magic_descriptor',
  'magic_buffer',
  'magic_error',
  'magic_getflags',
  'magic_setflags',
  'magic_version',
  'magic_load',
  'magic_load_buffers',
  'magic_compile',
  'magic_check',
  'magic_list',
  'magic_errno',
  'magic_setparam',
  'magic_getparam',
]

definitions = ['HAVE_VISIBILITY', 'HAVE_CONFIG_H', 'ZLIBSUPPORT']
definitions_windows = ['WIN32']

if BUILDSYS_TOOLSET_NAME == 'msvs':
    definitions_windows += ['_CRT_SECURE_NO_WARNINGS']
    disabled_warnings = ['4018', '4133', '4267', '4311', '4312', '4244']
elif BUILDSYS_TOOLSET_NAME == 'clang':
    disabled_warnings = ['unused-variable', 'int-to-pointer-cast', 'pointer-to-int-cast', 'uninitialized']
else:
    disabled_warnings = ['unused-variable', 'int-to-pointer-cast', 'pointer-to-int-cast', 'maybe-uninitialized']

include_dir_list = [
  '../../include',
  '../../vendor',
  '../../vendor/compat/include',
  '${@project_root}/zlib/include',
]

src_search_dir_list = [
    '../../vendor/src',
    '../../vendor/compat',
]

lib_list = [
  '../db'
]

build_list = [
  'magic.c',
  'apprentice.c',
  'funcs.c',
  'fsmagic.c',
  'print.c',
  'encoding.c',
  'compress.c',
  'getline.c',
  'buffer.c',
  'readelf.c',
  'softmagic.c',
  'ascmagic.c',
  'is_tar.c',
  'is_json.c',
  'readcdf.c',
  'localtime_r.c',
  'asctime_r.c',
  'gmtime_r.c',
  'cdf_time.c',
  'pread.c',
  'der.c',
  'fmtcheck.c',
  'cdf.c',
  'strcasestr.c',
  'ctime_r.c',
]

build_list_windows = ['regex.c']

if BUILDSYS_TOOLSET_NAME == 'msvs':
    build_list += ['asprintf.c', 'vasprintf.c']

if BUILDSYS_TARGET_PLATFORM != 'macosx':
    build_list += ['strlcpy.c']
