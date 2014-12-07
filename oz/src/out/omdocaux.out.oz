%%
%% omdocaux writer (include file)
%%

meth writeExercise(X)
   Self, writeTaggedItem(X attribs:[id mid item]
                         order:{Append CFM [hints solutions mcs]})
end

meth writeHint(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:CFM)
end

meth writeMc(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[symbols 'choice' hints answer])
end

meth writeChoice(X)
   Self, writeTaggedItem(X attribs:[mid]
                         order:CFM)
end

meth writeAnswer(X)
   Self, writeTaggedItem(X attribs:[verdict mid]
                         order:CFM)
end

meth writeOmlet(X)
   Self, writeTaggedItem(X attribs:[id mid type argstr function])
end

meth writePrivate(X)
   Self, writeTaggedItem(X attribs:[id mid item theory pto 'pto-version'
                                    format requires type classid codebase
                                    width height]
                         order:[metadata cmp data])
end

meth writeCode(X)
   Self, writeTaggedItem(X attribs:[id mid item theory pto 'pto-version'
                                    format requires type classid codebase
                                    width height]
                         order:[metadata cmps input output effect data])
end

meth writeInput(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps])
end

meth writeOutput(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps])
end

meth writeEffect(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps])
end

meth writeData(X)
   %% bug: content is of type ANY, but only #PCDATA is supported here
   Self, writeTaggedItem(X attribs:[id mid href]
                         order:[content])
end

meth writePresentation(X)
   Self, writeTaggedItem(X attribs:[fixity parent lbrack rbrack separator
                                    'bracket-style' id mid]
                         order:[uses])
end

meth writeUse(X)
   Self, writeTaggedItem(X attribs:[format lbrack rbrack separator
                                    'crossref-symbol']
                         order:[content])
end
