using TUMProject
using Documenter

DocMeta.setdocmeta!(TUMProject, :DocTestSetup, :(using TUMProject); recursive=true)

makedocs(;
    modules=[TUMProject],
    authors="Pascal Lehner <p-lehner@posteo.net>",
    repo="https://github.com/Pascal99-git/TUMProject.jl/blob/{commit}{path}#{line}",
    sitename="TUMProject.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
