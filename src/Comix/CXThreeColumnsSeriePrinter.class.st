"
CXThreeColumnsSeriePrinter new
	setBase: (CXBase new addNewSerieFromCollection: CXXMLImporter new import);
	save.
"
Class {
	#name : 'CXThreeColumnsSeriePrinter',
	#superclass : 'CXSeriePrinter',
	#category : 'Comix-Tools',
	#package : 'Comix',
	#tag : 'Tools'
}

{ #category : 'initialization' }
CXThreeColumnsSeriePrinter >> defaultFileName [
	^ 'ThreeColumnsSeries'
]

{ #category : 'latex' }
CXThreeColumnsSeriePrinter >> emitLatexEnd [
	stream
		nextPutAll:
			'
	\end{multicols}
	\end{document}'
]

{ #category : 'latex' }
CXThreeColumnsSeriePrinter >> emitLatexStart [
	stream
		nextPutAll:
			'\documentclass[]{article}
\usepackage[utf8]{inputenc}
\usepackage{calc}
\usepackage[pdftex]{graphicx}
\usepackage{vmargin}
\usepackage{multicol}
\setmarginsrb{1.2cm}{2cm}{1.2cm}{1.2cm}{0cm}{0cm}{0cm}{0cm}
\pagestyle{empty}
\newcommand{\squishlist}{
 \begin{list}{$\bullet$}
 { \setlength{\itemsep}{0pt}
   \setlength{\parsep}{3pt}
   \setlength{\topsep}{3pt}
   \setlength{\partopsep}{0pt}
   \setlength{\leftmargin}{1.5em}
   \setlength{\labelwidth}{1em}
   \setlength{\labelsep}{0.5em} } }
   
\newcommand{\squishend}{
 \end{list} }   



\begin{document}
\noindent
\scriptsize
\begin{multicols}{3}'
]
