/*
    Support functions for Embedthis Est

    Copyright (c) All Rights Reserved. See copyright notice at the bottom of the file.
 */

require ejs.tar
require ejs.unix

public function packageSourceFiles() {
    safeRemove(pkg)

    if (bit.cross) {
        return
    }
    let s = bit.settings
    let src = bit.dir.pkg.join('src')
    let pkg = src.join(s.product + '-' + s.version)
    pkg.makeDir()

    install(['Makefile', 'start.bit', 'main.bit'], pkg)
    install('bits', pkg)
    install('configure', pkg, {permissions: 0755})
    install('*.md', pkg, {fold: true, expand: true})
    install(['*.c', '*.h'], pkg, {
        exclude: /\.log$|\.lst$|ejs.zip|\.stackdump$|\/cache\/|huge.txt|\.swp$|\.tmp/,
    })
    install('utils', pkg, {
        exclude: /\.log$|\.lst$|ejs.zip|\.stackdump$|\/cache\/|huge.txt|\.swp$|\.tmp|\.o$|\.obj$|\.so$|\.dylib$/,
    })
    install('test', pkg, {
        exclude: /\.log$|\.lst$|ejs.zip|\.stackdump$|\/cache\/|huge.txt|\.swp$|\.tmp|\.tdat$|\.o$|\.obj$|\.so$|\.dylib$/,
    })
    install('doc', pkg, {
        exclude: /\/xml\/|\/html\/|Archive|\.mod$|\.so$|\.dylib$|\.o$/,
    })
    install('projects', pkg, {
        exclude: /\/Debug\/|\/Release\/|\.ncb|\.mode1v3|\.pbxuser/,
    })
    install('package', pkg, {})
    package(bit.dir.pkg.join('src'), 'src')
}

public function packageComboFiles() {
    if (bit.cross) {
        return
    }
    let s = bit.settings
    let src = bit.dir.pkg.join('src')
    let pkg = src.join(s.product + '-' + s.version)
    safeRemove(pkg)
    pkg.makeDir()
    install('projects/est-' + bit.platform.os + '-debug-bit.h', pkg.join('src/deps/est/bit.h'))
    install('package/start-flat.bit', pkg.join('src/deps/est/start.bit'))
    install('package/Makefile-flat', pkg.join('src/deps/est/Makefile'))
    install(['js.h', 'est.h'], 
        pkg.join('src/deps/est/est.h'), {
        cat: true,
        filter: /^#inc.*est.*$/mg,
        title: bit.settings.title + ' Library Source',
    })
    install(['*.c'], pkg.join('src/deps/est/estLib.c'), {
        cat: true,
        filter: /^#inc.*est.*$|^#inc.*mpr.*$|^#inc.*http.*$|^#inc.*customize.*$|^#inc.*edi.*$|^#inc.*mdb.*$|^#inc.*esp.*$/mg,
        exclude: /est.c|samples|test.c/,
        header: '#include \"est.h\"',
        title: bit.settings.title + ' Library Source',
    })
    install(['est.c'], pkg.join('src/deps/est/est.c'))
    package(bit.dir.pkg.join('src'), ['combo', 'flat'])
}

/*
    @copy   default
  
    Copyright (c) Embedthis Software LLC, 2003-2013. All Rights Reserved.
  
    This software is distributed under commercial and open source licenses.
    You may use the Embedthis GoAhead Open Source license or you may acquire a
    commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.md distributed with
    this software for full details and other copyrights.
  
    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=4 ts=4 expandtab

    @end
 */
