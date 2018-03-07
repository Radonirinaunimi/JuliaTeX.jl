__precompile__()
module JuliaTeX

#   This file is part of JuliaTeX.jl. It is licensed under the MIT license
#   Copyright (C) 2018 Michael Reed

export zathura, latexmk, pdf, texedit

using VerTeX

zathura(f::String,o=STDOUT) = spawn(`zathura $f`,(DevNull,o,STDERR))
latexmk(f::String,o=STDOUT) = run(`latexmk -silent -pdf -cd $f`)

function pdf(str::String,file::String="doc")
    open("/tmp/$file.tex", "w") do f
        write(f, VerTeX.article(str))
    end
    latexmk("/tmp/$file.tex",DevNull)
    zathura("/tmp/$file.pdf")
end

function texedit(data::Dict,file::String="/tmp/doc.tex")
    data["version"] ≠ ["VerTeX", "v\"0.1.0\""] && throw(error("wrong version"))
    open(file, "w") do f
        write(f, VerTeX.dict2tex(data))
    end
    run(`vim --servername julia $file`)
    out = ""
    open(file, "r") do f
        out = read(f,String)
    end
    return VerTeX.tex2dict(out,data)
end

function texedit(str::String,file::String="/tmp/doc.tex")
    texedit(VerTeX.tex2dict(VerTeX.article(str)),file)
end

export VerTeX

end # module
