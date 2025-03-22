# list all pages in subfolder

using Franklin

function listpages(folder)
    path = Franklin.PATHS[:folder]
    function find_title(pg)
        content = read(pg, String)
        m = match(r"@def\s+title\s+=\s+\"(.*)?\"", content)
        if m === nothing
            m = match(r"(?:^|\n)#\s+(.*?)(?:\n|$)", content)
            m === nothing && return "Unknown title"
        end
        return m.captures[1]
    end

    titles = []
    links = []
    for (root, _, files) in walkdir(folder) # (replace by your choice of dir)
        for file in files
            if file == "index.md"
                continue
            end
            md   = joinpath(root, file)
            html = replace(md, joinpath("src", "pages") => "pub")
            html = replace(html, r".md$" => "")

            t = find_title(md)
            push!(titles, t)
            l = Franklin.unixify(html)
            push!(links, l)
        end
    end
    return titles, links
end