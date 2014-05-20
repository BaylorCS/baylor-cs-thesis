% %%%%%%%%%%%%%%%%%%%%%%%%%
%
% Baylor University Master's Thesis LaTeX Template
% 
% Last Updated in June 2014
%
% %%%%%%%%%%%%%%%%%%%%%%%%%
%
% Some code derived from an early template
% created by Jeff Donahoo (2000), with additional
% inspiration from a template by David Jack (2011);
% rewritten and simplified by Jonathan Drake (2013).
% additional stuff by Alvin Jude
%
% %%%%%%%%%%%%%%%%%%%%%%%%%

% ================== Changelog ================================
% Added \comment{} - simplifies multiline comments
% Added 2 space after section and subsection
%
%
%
% =============================================================

\ProvidesClass{thesis}[2014/06/01]

% Class options:
% draft	draft heading, no graphics loaded, etc.
% short	front matter omitted
\newif\if@makeDraftThesis
\newif\if@makeShortThesis
\@makeDraftThesisfalse
\@makeShortThesisfalse
\DeclareOption{draft}{\@makeDraftThesistrue}
\DeclareOption{short}{\@makeShortThesistrue}
\ProcessOptions

% Load the parent class: report
\LoadClass[12pt,letterpaper]{report}
% ALVIN: Simplifies adding comments
\newcommand{\comment}[1]{}


% General document configuration
\AtBeginDocument
{
	\setlength{\topmargin}{0.0in}
	\setlength{\headheight}{0.0in}
	\setlength{\headsep}{0.0in}
	\setlength{\topskip}{0.0in}
	\setlength{\footskip}{0.4in}
	\setlength{\textheight}{9.0in} % 1in margins
	\setlength{\textwidth}{6.0in} % 1.25in margins
	\setlength{\oddsidemargin}{0.25in} % 1.25in margin relative to 1in default
	\setlength{\evensidemargin}{0.25in} % 1.25in margin relative to 1in default
	\setlength{\parindent}{0.5in}
	\setlength{\labelsep}{0.5em}
	\setlength{\labelwidth}{1.5em}
	
	\onecolumn
	\raggedbottom
	\doublespacing
	
	\setcounter{tocdepth}{2}
	\setcounter{secnumdepth}{3}
	
	\brokenpenalty=10000 % Discourages page breaks at hyphens
	\clubpenalty=10000 % Discourages orphan lines
	\widowpenalty=10000 % Discourages widow lines
}

% We need both double and single spacing
\RequirePackage{setspace}

% Set the caption label separator and spacing for all floats
\RequirePackage{caption}
\captionsetup{labelsep=period,font=singlespacing}

% Fix the ToC style for appendices
\RequirePackage[titletoc]{appendix}

% Set the names of prologue pages
\newcommand*{\ToCname}{TABLE OF CONTENTS}
\newcommand*{\LoFname}{LIST OF FIGURES}
\newcommand*{\LoTname}{LIST OF TABLES}
\newcommand*{\acknowledgename}{ACKNOWLEDGMENTS}
\newcommand*{\dedicationname}{DEDICATION}
\newcommand*{\appendicesname}{APPENDIX}
\renewcommand*{\chaptername}{CHAPTER}
\newcommand*{\bibliographyname}{BIBLIOGRAPHY}

% Convert to form expected by other packages
\renewcommand*{\appendixname}{\normalsize\normalfont\appendicesname}
\renewcommand*{\bibname}{\normalsize\normalfont\bibliographyname}

% Heading format
\renewcommand*{\thechapter}{\arabic{chapter}}
\renewcommand*{\thesection}{\thechapter.\arabic{section}}
\renewcommand*{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand*{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% Enumerated list labels
\renewcommand*{\theenumi}{\arabic{enumi}}
\renewcommand*{\theenumii}{\alph{enumii}}
\renewcommand*{\theenumiii}{\roman{enumiii}}
\renewcommand*{\theenumiv}{\alph{enumiv}}
\renewcommand*{\labelenumi}{(\theenumi)}
\renewcommand*{\labelenumii}{(\theenumii)}
\renewcommand*{\labelenumiii}{(\theenumiii)}
\renewcommand*{\labelenumiv}{(\theenumiii.\theenumiv)}

% Itemized list labels
\renewcommand*{\labelitemi}{\textbullet}
\renewcommand*{\labelitemii}{\textasteriskcentered}
\renewcommand*{\labelitemiii}{\normalfont \bfseries \textendash}
\renewcommand*{\labelitemiv}{\textperiodcentered}

% Margins for lists
\setlength{\leftmargini}{3.5em}
\setlength{\leftmarginiii}{2.2em}
\setlength{\leftmarginiv}{2.2em}
\setlength{\leftmarginv}{2.2em}
\setlength{\leftmarginvi}{2.2em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelwidth}{1.5em}

% Macro that converts the given number to a corresponding number name
\newcommand{\arabicText}[1]
{
	\ % Force a space
	\ifnum0<0#1 % Test for chapter number vs appendix letter
		\ifcase#1
			ZERO \or ONE \or TWO \or THREE \or FOUR \or
			FIVE \or SIX \or SEVEN \or EIGHT \or NINE \or TEN \or
			ELEVEN \or TWELVE \or THIRTEEN \or FOURTEEN \or
			FIFTEEN \or SIXTEEN \or SEVENTEEN \or EIGHTEEN \or
			NINETEEN \or TWENTY
		\fi
	\else
		#1 % Pass-through
	\fi
}

% Chapter command
\renewcommand\chapter
{
	\if@openright\cleardoublepage\else\clearpage\fi % first page on right
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter
}

% Chapter heading
\def\@chapter[#1]#2
{
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
		\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{8\p@}} % 8pt spacing
	\addtocontents{lot}{\protect\addvspace{8\p@}} % 8pt spacing
	{
		\centering
		\vspace*{0.25in}
		\MakeUppercase{\@chapapp{}}%
		\hspace{-0.25em}%
		\arabicText{\thechapter}\\
		#2\\
		\vspace{0.13in}
	}
	\@afterheading
}

% Section headings
% \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
\renewcommand{\section}
{%
	\@startsection{section}{1}{0pt}%
	{4ex }{4ex}%skip: 2 space before, 2 space after
	{\centering\normalfont\slshape\normalsize}
}
	
\renewcommand{\subsection}
{%
	\@startsection{subsection}{2}{0pt}%
	{4ex}{4ex}% skip: 2 space before, 2 space after
	{\normalfont\slshape\normalsize}
}

\renewcommand{\subsubsection}
{%
	\@startsection{subsubsection}{3}{\parindent}%
	{4ex}{-1em}%
	{\normalfont\slshape\normalsize}
}

% Internal boolean variables
\newcommand{\th@dedicationStash}{\relax}
\newcommand{\th@acknowledgementsStash}{\relax}
\newif\if@makeLoF
\newif\if@makeLoT
\newif\if@makeDedication
\newif\if@makeAcknowledgements
\newif\if@makeCopyright
\newif\if@makeReaderThree
\newif\if@makeReaderFour
\newif\if@makeReaderFive

% Initial values for boolean variables
\@makeLoFfalse
\@makeLoTfalse
\@makeCopyrighttrue
\@makeDedicationfalse
\@makeAcknowledgementsfalse
\@makeReaderThreefalse
\@makeReaderFourfalse
\@makeReaderFivefalse

% Internal macro for drawing signature lines
\newcommand*{\thesisSignature}[2]
{
		\normalsize
		\vspace{0.05in}
		\\
		\vrule width #2 height 0.2mm
        \\
        \vspace{-0.15in}
		#1
}

% Special footer for the signature page
\RequirePackage{fancyhdr}
\fancypagestyle{masters_title_page}
{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\cfoot{\footnotesize \textit{Page bearing signatures is kept on file in the Graduate School.}}
}

% Signature page (attempts to match BUGS 2013 guidelines)
\newcommand*{\thesisTitlePage}
{
	\thispagestyle{masters_title_page}
	\doublespacing
	
	\begin{center}
	\vspace*{0.1in}
		\thesisTitle \\
		by \\
		\thesisAuthorName, \thesisHolding \\
		A Thesis \\
		Approved by the \thesisDepartment
		\thesisSignature{\thesisDepartmentChair, Chairperson}{97mm}
	\\
	\vspace{0.1in}
	\singlespacing
    	Submitted to the Graduate Faculty of\\ 
	Baylor University in Partial Fulfillment of the \\
	Requirements for the Degree of \\
	\doublespacing
	\thesisDegree
	
	\vspace{0.25in}
	\vfill
	
	{
		\addtolength{\leftskip}{-2.25in}
     		Approved by the Thesis Committee
     		\thesisSignature{\thesisMentor, Chairperson}{80mm}
     		\thesisSignature{\thesisReaderOne}{80mm}
     		\thesisSignature{\thesisReaderTwo}{80mm}
		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm} \fi
		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm} \fi
		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm} \fi
		\\
	}
	
	\vspace{0.25in}
	\vfill
	
	{
		\addtolength{\leftskip}{2.6in}
		Accepted by the Graduate School \\
		\vspace{-0.075in}
		\thesisConfDate
		\thesisSignature{\thesisDean, Dean}{80mm} \\
	}
	
	\end{center}
	\clearpage
}

% Copyright page (attempts to match BUGS 2013 guidelines)
\newcommand*{\thesisCopyrightPage}
{
	\if@makeCopyright
		\thispagestyle{empty}
		\vspace*{8.19in}
		\begin{center}
		Copyright \copyright{} \the\year\ by  \thesisAuthorName \\
		All rights reserved
		\end{center}
		\clearpage
	\fi
}

% Abstract page (attempts to match BUGS 2013 guidelines)
\newcommand{\thesisAbstractpage}
{
	\thispagestyle{empty}
	\if@makeDraftThesis
		\begin{center}
			\Huge Draft \\
			\Large \today \normalsize
		\end{center}
		\vspace{-8em}
	\fi
	\doublespacing
	\vspace*{1.12in}
	\begin{center}
		ABSTRACT
		\ \\
		\thesisTitle
		\ \\
		\thesisAuthorName, \thesisSeeking
		\ \\
        \thesisMentorTitle: \thesisMentor
        \vspace*{0.08in}
    \end{center}
    \doublespacing
	\hspace{\parindent}
	\thesisAbstract
	\clearpage
}

% Table of contents page
\newcommand{\thesisToCpage}
{
	\renewcommand*{\contentsname}{\vspace*{-0.5in}\centering\normalsize\normalfont\ToCname\vspace{-0.25in}}
	\tableofcontents
	\clearpage
}

% List of figures page (optional)
\newcommand{\thesisLoFpage}
{
	\if@makeLoF
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\addcontentsline{toc}{part}{\normalsize\normalfont\LoFname}
		\renewcommand*{\listfigurename}{\vspace*{-0.5in}\centering\normalsize\normalfont\LoFname\vspace{-0.25in}}
		\listoffigures
		\clearpage
	\fi
}

% List of tables page (optional)
\newcommand{\thesisLoTpage}{
	\if@makeLoT
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\addcontentsline{toc}{part}{\normalsize\normalfont\LoTname}
		\renewcommand*{\listtablename}{\vspace*{-0.5in}\centering\normalsize\normalfont\LoTname\vspace{-0.25in}}
		\listoftables
		\clearpage
	\fi
}

% Acknowledgments page (optional)
\newcommand{\thesisAcknowledgementpage}
{
	\if@makeAcknowledgements
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\addcontentsline{toc}{part}{\normalsize\normalfont\acknowledgename}
		\begin{center}\vspace*{0.25in}\normalfont\normalsize\acknowledgename\end{center}
		\hspace{\parindent}
		\th@acknowledgementsStash
		\clearpage
	\fi
}

% Dedication page (optional)
\newcommand{\thesisDedicationpage}
{
	\if@makeDedication		
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\addcontentsline{toc}{part}{\normalsize\normalfont\dedicationname}
		\begin{center}\vspace*{0.25in}\normalfont\normalsize\dedicationname\end{center}
		
		\begin{center}\th@dedicationStash\end{center}
		\clearpage
	\fi
}

% The thesis prologue (front matter)
\newcommand{\thesisPrologue}
{
	% Where to start counting pages (Baylor's first pages are unpaginated, but counted!)
	\pagenumbering{roman}
	
	% Unpaginated preliminary pages
	\thesisAbstractpage
	\thesisTitlePage
	\thesisCopyrightPage
	
	% Where to start paginating (thus making ToC page "iv" or so)
	\pagestyle{plain}
	
	% Paginated preliminary pages
	\thesisToCpage
	\thesisLoFpage
	\thesisLoTpage
	\thesisAcknowledgementpage
	\thesisDedicationpage
}

% Intercept the bibliography body
\AtBeginDocument
{
	\def\thebibliography#1
	{
		\clearpage
		\addcontentsline{toc}{chapter}{\bibname}
		\vspace*{0.25in}
		\centering\normalfont\normalsize\bibname
		\vspace{2ex}
		\singlespacing
		\list{[\arabic{enumi}]}
		{
	 		\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
	 		\advance\leftmargin\labelsep
	 		\advance\leftmargin\bibindent
			\itemindent -\bibindent
			\listparindent \itemindent
			\usecounter{enumi}
		}
		\def\newblock{\hskip .11em plus .33em minus -.07em}
		\sloppy
	 	\sfcode`\.=1000\relax
	}
}

% Intercept the main document (basically the main function here)
\let\interceptedDocument\document
\renewcommand*{\document}
{
	\interceptedDocument
	
	% Front matter
	\if@makeShortThesis
		\thesisAbstractpage
	\else
		\thesisPrologue
	\fi
	
	% Document body follows
	\doublespacing
	\pagenumbering{arabic}
}

% Expected parameters
\renewcommand*{\title}[1]{\gdef\thesisTitle{#1}}
\newcommand*{\degree}[1]{\gdef\thesisDegree{#1}}
\newcommand*{\supervisor}[1]{\gdef\thesisMentor{#1}}
\newcommand*{\supervisorTitle}[1]{\gdef\thesisMentorTitle{#1}}
\newcommand*{\seeking}[1]{\gdef\thesisSeeking{#1}}
\newcommand*{\holding}[1]{\gdef\thesisHolding{#1}}
\newcommand*{\readerOne}[1]{\gdef\thesisReaderOne{#1}}
\newcommand*{\readerTwo}[1]{\gdef\thesisReaderTwo{#1}}
\newcommand*{\department}[1]{\gdef\thesisDepartment{#1}}
\newcommand*{\departmentChair}[1]{\gdef\thesisDepartmentChair{#1}}
\newcommand*{\graduateDean}[1]{\gdef\thesisDean{#1}}
\renewcommand*{\date}[1]{\gdef\thesisConfDate{#1}}
\renewcommand*{\author}[1]{\gdef\thesisAuthorName{#1}}
\renewcommand{\abstract}[1]{\gdef\thesisAbstract{#1}}

% Optional parameters
\newcommand*{\acknowledgements}[1]{\@makeAcknowledgementstrue \gdef\th@acknowledgementsStash{#1}}
\newcommand{\dedication}[1]{\@makeDedicationtrue \gdef\th@dedicationStash{#1}}
\newcommand*{\readerThree}[1]{\@makeReaderThreetrue \gdef\thesisReaderThree{#1}}
\newcommand*{\readerFour}[1]{\@makeReaderFourtrue \gdef\thesisReaderFour{#1}}
\newcommand*{\readerFive}[1]{\@makeReaderFivetrue \gdef\thesisReaderFive{#1}}
\newcommand*{\makeListOfFigures}{\@makeLoFtrue}
\newcommand*{\makeListOfTables}{\@makeLoTtrue}

% Handy table spacing macros: \abovespace, \belowspace
\def\abovestrut#1{\rule[0in]{0in}{#1}\ignorespaces}
\def\belowstrut#1{\rule[-#1]{0in}{#1}\ignorespaces}
\def\abovespace{\abovestrut{0.20in}}
\def\aroundspace{\abovestrut{0.20in}\belowstrut{0.10in}}
\def\belowspace{\belowstrut{0.10in}}
\def\amanda{\abovespace\belowspace}%wins every time

% Handy thing for getting good spacing when section and subsection are adjacent
\newcommand*{\stack}{\vspace{4ex}}
