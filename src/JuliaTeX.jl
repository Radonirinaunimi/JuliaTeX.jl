module JuliaTeX

#   This file is part of JuliaTeX.jl. It is licensed under the MIT license
#   Copyright (C) 2018 Michael Reed

export zathura, latexmk, article, pdf, restore, texedit

artbegin = """
\\documentclass[]{article}
\\usepackage[active,tightpage]{preview}
\\setlength\\PreviewBorder{7.77pt}
\\usepackage{varwidth}
\\AtBeginDocument{\\begin{preview}\\begin{varwidth}{\\linewidth}}
\\AtEndDocument{\\end{varwidth}\\end{preview}}

\\begin{document}
"""

artend = "\n\\end{document}"

zathura(f::String,o=STDOUT) = spawn(`zathura $f`,(DevNull,o,STDERR))
latexmk(f::String,o=STDOUT) = run(`latexmk -silent -pdf -cd $f`)

function article(str::String,file::String)
    open(file, "w") do f
        write(f, artbegin*str*artend)
    end
end
function restore(file::String)
    out = ""
    open(file, "r") do f
        out = readstring(f)
    end
    String(split(split(out,"\\begin{document}\n")[2],"\n\\end{document}")[1])
end

function pdf(str::String,file::String="doc")
    article(str,"/tmp/$file.tex")
    latexmk("/tmp/$file.tex",DevNull)
    zathura("/tmp/$file.pdf")
end

function texedit(str::String,file::String="/tmp/doc.tex")
    article(str,file)
    run(`vim --servername julia $file`)
    restore(file)
end

end # module
