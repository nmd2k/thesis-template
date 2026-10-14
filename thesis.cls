%%
%% thesis.cls -- A thesis class built on the LaTeX 'book'/'extbook'
%% class, reusing the typography and workflow ideas of the ACM 'acmart'
%% class.
%%
%% Copyright (C) 2026 Dung Nguyen Manh
%%
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3c of this license
%% or (at your option) any later version. The latest version of this
%% license is in <https://www.latex-project.org/lppl.txt>.
%%
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is Dung Nguyen Manh.
%%
%% The review line-numbering mechanism and the ACM colour palette are
%% adapted from acmart (Copyright 2016-2026 ACM, LPPL 1.3).
%%
%% Options:
%%   print          two-sided copy for printing and binding.
%%   duplex         two-sided (double-sided) copy: mirrored (inner/outer)
%%                  margins, mirrored running heads and page numbers on
%%                  the outer edge, for printing and binding.
%%   screen         one-sided copy for reading on screen (coloured links).
%%   review         one-sided reading/review copy with line numbers.
%%   biblatex       use biblatex (acmnumeric/acmauthoryear) instead of BibTeX
%%   authoryear     author-year citations
%%   onehalf        one-and-a-half line spacing (default)
%%   single         single line spacing
%%   double         double line spacing
%%   font=libertine Libertine text face (default)
%%   font=times     Times-like text face (pdfLaTeX only)
%%   font=palatino  Palatino-like text face (pdfLaTeX only)
%%   <size>         base font size: 10pt, 11pt, 12pt, 14pt (default), 17pt, 20pt
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2026/10/14 v0.1 A thesis class]

\RequirePackage{iftex}

\newif\if@thesis@review
\newif\if@thesis@print
\newif\if@thesis@duplex
\newif\if@thesis@screen
\newif\if@thesis@biblatex
\newif\if@thesis@authoryear
\newif\if@thesis@onehalf
\newif\if@thesis@double
\newif\if@thesis@single
\newif\if@thesis@font@times
\newif\if@thesis@font@palatino

\DeclareOption{review}{\@thesis@reviewtrue}
\DeclareOption{print}{\@thesis@printtrue}
\DeclareOption{duplex}{\@thesis@duplextrue}
\DeclareOption{screen}{\@thesis@screentrue}
\DeclareOption{biblatex}{\@thesis@biblatextrue}
\DeclareOption{authoryear}{\@thesis@authoryeartrue}
\DeclareOption{onehalf}{\@thesis@onehalftrue}
\DeclareOption{double}{\@thesis@doubletrue}
\DeclareOption{single}{\@thesis@singletrue}
\DeclareOption{font=libertine}{\@thesis@font@timesfalse\@thesis@font@palatinofalse}
\DeclareOption{font=times}{\@thesis@font@timestrue\@thesis@font@palatinofalse}
\DeclareOption{font=palatino}{\@thesis@font@palatinotrue\@thesis@font@timesfalse}
\def\@thesis@size{14pt}
\DeclareOption{10pt}{\def\@thesis@size{10pt}}
\DeclareOption{11pt}{\def\@thesis@size{11pt}}
\DeclareOption{12pt}{\def\@thesis@size{12pt}}
\DeclareOption{14pt}{\def\@thesis@size{14pt}}
\DeclareOption{17pt}{\def\@thesis@size{17pt}}
\DeclareOption{20pt}{\def\@thesis@size{20pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extbook}}
\ProcessOptions\relax

\if@thesis@review\else\if@thesis@screen\else\@thesis@printtrue\fi\fi

%% Default line spacing is one-and-a-half (a thesis convention); the
%% single and double options override it.
\if@thesis@double\else\if@thesis@single\else\@thesis@onehalftrue\fi\fi

%% print and duplex are two-sided copies; screen and review are
%% one-sided reading copies. duplex always forces two-sided output so
%% that odd/even pages mirror correctly.
\if@thesis@duplex
  \PassOptionsToClass{twoside}{extbook}
\else
  \if@thesis@screen
    \PassOptionsToClass{oneside}{extbook}
  \else
    \if@thesis@review
      \PassOptionsToClass{oneside}{extbook}
    \else
      \PassOptionsToClass{twoside}{extbook}
    \fi
  \fi
\fi

\PassOptionsToClass{\@thesis@size}{extbook}
\LoadClass[openany]{extbook}

\RequirePackage{amsmath}
\RequirePackage{amsthm}

%%
%% Typefaces. Default is Libertine (with Inconsolata and newtxmath);
%% font=times or font=palatino select a Times- or Palatino-like family.
%%
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \if@thesis@font@times
    \RequirePackage{newtxtext}
    \RequirePackage[varqu]{zi4}
    \RequirePackage{newtxmath}
  \else
    \if@thesis@font@palatino
      \RequirePackage{mathpazo}
      \RequirePackage[varqu]{zi4}
    \else
      \RequirePackage[tt=false, type1=true]{libertine}
      \RequirePackage[varqu]{zi4}
      \RequirePackage[libertine]{newtxmath}
    \fi
  \fi
\else
  \if@thesis@font@times\else\if@thesis@font@palatino
    \ClassWarning{thesis}{font=times and font=palatino are only
      supported with pdfLaTeX; using Libertine instead}%
  \fi\fi
  \RequirePackage{amssymb}
  \RequirePackage{unicode-math}
  \setmathfont[Scale=MatchUppercase]{LibertinusMath-Regular.otf}
  \setmathfont{latinmodern-math.otf}[range={cal}]
  \RequirePackage[tt=false]{libertine}
  \setmonofont[StylisticSet=3]{inconsolata}
\fi
\let\liningnums\relax

%%
%% Colour palette (adapted from the ACM acmart class).
%%
\RequirePackage{xcolor}
\definecolor{thesisBlue}{cmyk}{1,0.1,0,0.1}
\definecolor{thesisYellow}{cmyk}{0,0.16,1,0}
\definecolor{thesisOrange}{cmyk}{0,0.42,1,0.01}
\definecolor{thesisRed}{cmyk}{0,0.90,0.86,0}
\definecolor{thesisLightBlue}{cmyk}{0.49,0.01,0,0}
\definecolor{thesisGreen}{cmyk}{0.20,0,1,0.19}
\definecolor{thesisPurple}{cmyk}{0.55,1,0,0.15}
\definecolor{thesisDarkBlue}{cmyk}{1,0.58,0,0.21}

%%
%% Page geometry (A4). print and duplex are two-sided with a 40mm
%% binding (inner) margin, so odd and even pages get different left/right
%% padding (inner is always the binding edge). screen and review are
%% one-sided with equal 25mm margins. The running head sits just above
%% the text block (about 15mm from the top) and the page number 15mm from
%% the bottom.
%%
\RequirePackage{geometry}
\if@thesis@duplex
  \geometry{a4paper, heightrounded,
    inner=40mm, outer=25mm, top=24mm, bottom=24mm,
    headheight=17pt, headsep=3mm, footskip=25.5pt}
\else
  \if@thesis@print
    \geometry{a4paper, heightrounded,
      inner=40mm, outer=25mm, top=24mm, bottom=24mm,
      headheight=17pt, headsep=3mm, footskip=25.5pt}
  \else
    \geometry{a4paper, heightrounded,
      left=25mm, right=25mm, top=24mm, bottom=24mm,
      headheight=17pt, headsep=3mm, footskip=25.5pt}
  \fi
\fi

\setlength\parindent{1.5em}
\setlength\parskip{\z@}
\setlength\emergencystretch{1.5em}

%%
%% Core packages.
%%
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{url}
\ifPDFTeX
  \RequirePackage{microtype}
\fi
\RequirePackage{setspace}
\if@thesis@double
  \doublespacing
\else
  \if@thesis@onehalf
    \onehalfspacing
  \fi
\fi

%%
%% ---------------------------------------------------------------------
%% TYPOGRAPHY --- the settings a thesis usually wants to adjust.
%%
%% Redefine any of these macros, or use a single \thesissetup{...}
%% in the preamble of thesis.tex, for example:
%%
%%   \thesissetup{
%%     head      = {\sffamily\footnotesize},
%%     chapter   = {\sffamily\bfseries\Huge},
%%     section   = {\sffamily\bfseries\LARGE},
%%     linespread = 1.15,
%%     parskip   = 6pt,
%%   }
%%
%% The text face is chosen with the class option font= (libertine|times|palatino),
%% and the base body size with 10pt|11pt|12pt|14pt (default)|17pt|20pt.
%% Headings are serif and bold by default, matching the body text.
%% /---------------------------------------------------------------------
%%
\newcommand\thesisHeadFont{\small}
\newcommand\thesisFootFont{\small}
\newcommand\thesisChapterLabelFont{\bfseries\Large}
\newcommand\thesisChapterFont{\bfseries\LARGE}
\newcommand\thesisSectionFont{\bfseries\large}
\newcommand\thesisSubsectionFont{\bfseries\large}
\newcommand\thesisSubsubsectionFont{\bfseries}

\RequirePackage{keyval}
\define@key{thesis}{head}{\renewcommand\thesisHeadFont{#1}}
\define@key{thesis}{foot}{\renewcommand\thesisFootFont{#1}}
\define@key{thesis}{chapterlabel}{\renewcommand\thesisChapterLabelFont{#1}}
\define@key{thesis}{chapter}{\renewcommand\thesisChapterFont{#1}}
\define@key{thesis}{section}{\renewcommand\thesisSectionFont{#1}}
\define@key{thesis}{subsection}{\renewcommand\thesisSubsectionFont{#1}}
\define@key{thesis}{subsubsection}{\renewcommand\thesisSubsubsectionFont{#1}}
\define@key{thesis}{parindent}{\setlength\parindent{#1}}
\define@key{thesis}{parskip}{\setlength\parskip{#1}}
\define@key{thesis}{linespread}{\renewcommand{\baselinestretch}{#1}}
\newcommand\thesissetup[1]{\setkeys{thesis}{#1}}

%%
%% Theorem environments.
%%
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{proposition}[theorem]{Proposition}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}

%%
%% Sectioning: sans-serif headings, with a clear size
%% hierarchy: chapter > section > subsection > subsubsection.
%%
\RequirePackage{titlesec}
\titleformat{\chapter}[display]
  {\normalfont\raggedright}
  {\thesisChapterLabelFont\chaptertitlename\ \thechapter}
  {0.5ex}
  {\thesisChapterFont}
\titlespacing*{\chapter}{0pt}{30mm}{2\baselineskip}
\titleformat{\section}[hang]
  {\normalfont\thesisSectionFont}{\thesection}{1em}{}
\titlespacing*{\section}{0pt}{1.6ex plus 1ex minus .2ex}{0.8ex}
\titleformat{\subsection}[hang]
  {\normalfont\thesisSubsectionFont}{\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{1.4ex plus .8ex minus .2ex}{0.6ex}
\titleformat{\subsubsection}[hang]
  {\normalfont\thesisSubsubsectionFont}{\thesubsubsection}{1em}{}

%%
%% Review line numbers. Borrowed from the ACM acmart class: a ruler of
%% numbers is generated one per \baselineskip down the margin, so every
%% line is numbered, blank lines included.
%%
\newsavebox{\thesis@linecount@bx}
\newlength\thesis@linecount@bxht
\newcount\thesis@linecount
\thesis@linecount\@ne\relax
\def\thesis@mk@linecount{%
  \if@thesis@review
    \savebox{\thesis@linecount@bx}[4em][t]{\parbox[t]{4em}{\normalfont\normalsize
        \setlength{\thesis@linecount@bxht}{0pt}%
        \loop{\color{thesisRed}\scriptsize\the\thesis@linecount}\\
          \global\advance\thesis@linecount by \@ne
          \addtolength{\thesis@linecount@bxht}{\baselineskip}%
        \ifdim\thesis@linecount@bxht<\textheight\repeat
        {\color{thesisRed}\scriptsize\the\thesis@linecount}\hfill
        \global\advance\thesis@linecount by \@ne}}%
  \fi}
\def\thesis@linecountL{%
  \if@thesis@review
    \thesis@mk@linecount
    \begin{picture}(0,0)%
      \put(-34,-22){\usebox{\thesis@linecount@bx}}%
    \end{picture}%
  \fi}

%%
%% Running heads (chapter/section) and feet (page number). In two-sided
%% (duplex) output the running head is placed on the outer edge of every
%% page (even: left, odd: right) so it always aligns to the same side of
%% the sheet when the pages are flipped. In duplex mode the page number
%% also sits on the outer edge; otherwise it is centred. In review mode
%% the line-number ruler always sits in the left margin (both odd and even
%% pages) with the running head on the right.
%%
\RequirePackage{fancyhdr}
\fancyhf{}
\newcommand\thesis@runningmark{%
  \thesisHeadFont
  \ifodd\value{page}\nouppercase{\rightmark}\else\nouppercase{\leftmark}\fi}
\if@twoside
  \if@thesis@review
    \fancyhead[LE]{\thesis@linecountL}
    \fancyhead[LO]{\thesis@linecountL}
    \fancyhead[RE]{\thesisHeadFont\nouppercase{\leftmark}}
    \fancyhead[RO]{\thesisHeadFont\nouppercase{\rightmark}}
  \else
    \fancyhead[LE]{\thesisHeadFont\nouppercase{\leftmark}}
    \fancyhead[RO]{\thesisHeadFont\nouppercase{\rightmark}}
  \fi
\else
  \if@thesis@review
    \fancyhead[L]{\thesis@linecountL}
    \fancyhead[R]{\thesis@runningmark}
  \else
    \fancyhead[L]{\ifodd\value{page}\else\thesisHeadFont\nouppercase{\leftmark}\fi}
    \fancyhead[R]{\ifodd\value{page}\thesisHeadFont\nouppercase{\rightmark}\fi}
  \fi
\fi
\if@thesis@duplex
  \fancyfoot[LE,RO]{\thesisFootFont\thepage}
\else
  \fancyfoot[C]{\thesisFootFont\thepage}
\fi
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\pagestyle{fancy}

%% A plain page style for covers, chapter openings and front matter:
%% no running head, page number in the footer. Defined directly (rather
%% than with \fancypagestyle) so it does not disturb the fancy fields.
%% In duplex mode the page number moves to the outer edge.
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \def\@oddhead{\thesis@linecountL\hfil}%
  \def\@evenhead{\thesis@linecountL\hfil}%
  \if@thesis@duplex
    \def\@oddfoot{\hfil\thesisFootFont\thepage}%
    \def\@evenfoot{\thesisFootFont\thepage\hfil}%
  \else
    \def\@oddfoot{\hfil\thesisFootFont\thepage\hfil}%
    \def\@evenfoot{\hfil\thesisFootFont\thepage\hfil}%
  \fi
}

%% Front matter (cover, contents, lists, ) uses plain pages
%% (no running head); main and back matter use the running head.
\let\thesis@orig@frontmatter\frontmatter
\renewcommand\frontmatter{\thesis@orig@frontmatter\pagestyle{plain}}
\let\thesis@orig@mainmatter\mainmatter
\renewcommand\mainmatter{\thesis@orig@mainmatter\pagestyle{fancy}}

%%
%% Names.
%%
\renewcommand\contentsname{Contents}
\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
\renewcommand\bibname{Bibliography}
\renewcommand\appendixname{Appendix}
\providecommand\abstractname{Abstract}
\newcommand\keywordsname{Keywords}
\providecommand\BibTeX{Bib\TeX}
\providecommand\BibLaTeX{Bib\LaTeX}

%% The cover page and its metadata live in cover.sty, loaded from
%% thesis.tex, so that they can be customised independently.

\newcommand\keywords[1]{\par\vspace{1em}\noindent
  \textbf{\keywordsname:}~#1\par}

\newcommand\Description[2][]{}

%%
%% Appendices stay lettered even after \backmatter.
%%
\renewcommand\appendix{\par
  \@mainmattertrue
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}

%%
%% Front-matter special sections. \frontsection starts an unnumbered
%% chapter-sized page and adds it to the table of contents.
%% \begin{frontchapter}[Title] ... \end{frontchapter} uses it for any of
%% the preliminary parts; the title is whatever you pass. Both
%% \begin{frontchapter}[Title] and \begin{frontchapter}{Title} work.
%%
\newcommand\frontsection[1]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}%
}
\def\frontchapter@opt[#1]{\frontsection{#1}}
\def\frontchapter@req#1{\frontsection{#1}}
\newenvironment{frontchapter}{%
  \@ifnextchar[{\frontchapter@opt}{\frontchapter@req}}{\par}

%%
%% Abstract: a compact title block (title, author and, if the cover
%% package is loaded, the supervisors), a rule, then the abstract text.
%% Use  \begin{abstract} ... \keywords{...} \end{abstract}
%%
\newenvironment{abstract}{%
  \clearpage
  \thispagestyle{plain}%
  \addcontentsline{toc}{chapter}{\abstractname}%
  \noindent\rule{\textwidth}{0.2pt}
  \begin{center}%
    {\large\bfseries\@title\par}%
    \ifx\@author\@empty\else
      \vspace{0.4em}{\normalsize\@author\par}\fi
    \@ifundefined{@thesissupervisor}{}{%
      \ifx\@thesissupervisor\@empty\else
        \vspace{0.6em}{\normalsize Supervisor: \@thesissupervisor\par}\fi}%
    \@ifundefined{@thesiscosupervisor}{}{%
      \ifx\@thesiscosupervisor\@empty\else
        {\normalsize Co-supervisor: \@thesiscosupervisor}\fi} \\
  \noindent\rule{\textwidth}{0.2pt}\par
  \vspace{1em}%
  {\noindent\bfseries\large\abstractname\par}%
  \vspace{0.4em}%
  \end{center}%
}{%
  \par
}

%%
%% Bibliography.
%%
\if@thesis@biblatex
  \if@thesis@authoryear
    \RequirePackage[style=acmauthoryear,backend=biber]{biblatex}
  \else
    \RequirePackage[style=acmnumeric,backend=biber]{biblatex}
  \fi
  \ExecuteBibliographyOptions{heading=bibintoc}
\else
  \if@thesis@authoryear
    \RequirePackage[authoryear]{natbib}
  \else
    \RequirePackage[numbers,sort&compress]{natbib}
  \fi
  \bibliographystyle{ACM-Reference-Format}
  \renewcommand\bibsection{\frontsection{\bibname}}
\fi

%%
%% The table of contents, the lists and the bibliography are always
%% single-spaced, whatever the body line spacing.
%%
\let\thesis@orig@tableofcontents\tableofcontents
\renewcommand\tableofcontents{%
  \begin{spacing}{1}\thesis@orig@tableofcontents\end{spacing}}
\let\thesis@orig@listoffigures\listoffigures
\renewcommand\listoffigures{%
  \begin{spacing}{1}\thesis@orig@listoffigures\end{spacing}}
\let\thesis@orig@listoftables\listoftables
\renewcommand\listoftables{%
  \begin{spacing}{1}\thesis@orig@listoftables\end{spacing}}
\if@thesis@biblatex\else
  \let\thesis@orig@thebibliography\thebibliography
  \let\thesis@orig@endthebibliography\endthebibliography
  \renewcommand\thebibliography[1]{%
    \begin{spacing}{1}\thesis@orig@thebibliography{#1}}
  \renewcommand\endthebibliography{%
    \thesis@orig@endthebibliography\end{spacing}}
\fi

%%
%% Hyperlinks: coloured for screen, hidden for print/review.
%%
\RequirePackage{hyperref}
\if@thesis@screen
  \hypersetup{colorlinks=true,
    linkcolor=thesisPurple, citecolor=thesisGreen,
    urlcolor=thesisDarkBlue, filecolor=thesisDarkBlue}
\else
  \hypersetup{hidelinks}
\fi
\hypersetup{bookmarksnumbered=true, pdfdisplaydoctitle=true}

%%
%% End of thesis.cls
%%
\endinput
