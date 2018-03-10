try
    kill(spawn(`vim --servername`))
    @info "vim editor support enabled (required by JuliaTeX)"
catch
    @warn "vim editor not installed! (required by JuliaTeX)"
end
try
    kill(spawn(`latexmk`))
    @info "latexmk compiler support enabled (required by JuliaTeX)"
catch
    @warn "latexmk compiler not installed! (required by JuliaTeX)"
end
try
    kill(spawn(`zathura`))
    @info "zathura viewer support enabled (required by JuliaTeX)"
catch
    @warn "zathura viewer not installed! (required by JuliaTeX)"
end
@info "vimtex is the recommended plugin for vim & JuliaTeX"
