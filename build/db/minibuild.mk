#import "."

module_type = 'lib-static'
module_name = 'magic_database'
build_list  = ['magic_db.c'] # auto-generated

pre_build_noarch = ['mkmagicdb']
