return {
    -- Examples of Greek letter snippets, autotriggered for efficiency
    s({ trig = ";a", snippetType = "autosnippet" },
        {
            t("\\alpha"),
        }
    ),
    s({ trig = ";b", snippetType = "autosnippet" },
        {
            t("\\beta"),
        }
    ),
    s({ trig = ";g", snippetType = "autosnippet" },
        {
            t("\\gamma"),
        }
    ),
    s({ trig = "eq", dscr = "A LaTeX equation environment" },
        fmt([[
      \begin{equation}
          <>
      \end{equation}
    ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
        fmta(
            "\\texttt{<>}",
            { i(1) }
        )
    ),
    s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" },
        fmt(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2)
            },
            { delimiters = "<>" } -- manually specifying angle bracket delimiters
        )
    ),
}
