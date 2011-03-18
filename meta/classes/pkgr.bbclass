# When using the 'basichash' signature handler, which stores the hash in the
# stamps, we no longer need to rely on PR to handle rebuilds, so we can reset
# it (for now) and automatically set/increment PKGR for packaging when the
# signature of the task it's used in changes.

BB_HASHBASE_WHITELIST += "PKGR reset_pr get_pkgr"

python reset_pr() {
    if (isinstance(e, bb.event.RecipeParsed) and
        e.data.getVar('BB_SIGNATURE_HANDLER', True) == 'basichash'):
        e.data.setVar('PR', '0')
        e.data.setVar('PKGR', '${@get_pkgr(d)}')
}

addhandler reset_pr

def get_pkgr(d):
    import cPickle as pickle
    class PKGR(tuple):
        def __str__(self):
            return pickle.dumps(tuple(self))

        @classmethod
        def from_string(cls, s):
            return cls(pickle.loads(str(s)))

    ident = '%s-%s' % (d.getVar('PN', True), d.getVar('PV', True))
    pkgrhash = d.getVar('BB_TASKHASH', True)
    if pkgrhash is None:
        return 'UNSET'

    persist = bb.persist_data.persist('PKGR', d)
    value = persist[ident]
    if value is not None:
        pkgr = PKGR.from_string(value)
        if pkgr[0] != pkgrhash:
            # hash has changed, bump revision
            pkgr = PKGR((pkgrhash, pkgr[1] + 1))
    else:
        pkgr = PKGR((pkgrhash, 0))

    persist[ident] = str(pkgr)
    return pkgr[1]
