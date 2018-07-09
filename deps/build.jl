try
    kill(run(`vim --servername`,wait=false))
    @info "vim editor support enabled (required by JuliaTeX)"
catch
    @warn "vim editor not installed! (required by JuliaTeX)"
end
try
    kill(run(`latexmk`,wait=false))
    @info "latexmk compiler support enabled (required by JuliaTeX)"
catch
    @warn "latexmk compiler not installed! (required by JuliaTeX)"
end
try
    kill(run(`zathura`,wait=false))
    @info "zathura viewer support enabled (required by JuliaTeX)"
catch
    @warn "zathura viewer not installed! (required by JuliaTeX)"
end
@info "vimtex is the recommended plugin for vim & JuliaTeX"
