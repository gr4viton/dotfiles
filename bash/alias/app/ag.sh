
# AG = ag-silversearcher
alias agp='ag --py '
# find all non-get dicts value accesses via str key (=dict_['something'])

agp_dict() {
    agp "\[['|\"][^,]*?['|\"]\]";
}


