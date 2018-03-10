__precompile__()
module JuliaTeX

#   This file is part of JuliaTeX.jl. It is licensed under the MIT license
#   Copyright (C) 2018 Michael Reed

export zathura, latexmk, pdf, texedit

using VerTeX

zathura(f::String,o=STDOUT) = spawn(`zathura $f`,(DevNull,o,STDERR))
latexmk(f::String,o=STDOUT) = run(`latexmk -silent -pdf -cd $f`)

function showpdf(str::String)
    latexmk(str,DevNull)
    zathura(replace(str,r".tex$",".pdf"))
end

function pdf(str::String,file::String="doc")
    open("/tmp/$file.tex", "w") do f
        write(f, VerTeX.article(str))
    end
    showpdf("/tmp/$file.tex")
end

pdf(data::Dict) = showpdf(savetex(data))

function texedit(data::Dict,file::String="/tmp/doc.tex")
    load = VerTeX.writetex(data,file)
    run(`vim --servername julia $load`)
    ret = VerTeX.tex2dict(VerTeX.readtex(load),data)
    return load == file ? ret : VerTeX.save(ret)
end

function texedit(str::String,file::String="/tmp/doc.tex")
    texedit(VerTeX.tex2dict(VerTeX.article(str)),file)
end

export VerTeX

end # module
