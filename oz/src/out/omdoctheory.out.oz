%%
%% omdoctheory writer (include file)
%%

meth writeTheory(X)
   Self, writeTaggedItem(X attribs:[id]
                         order:[metadata commonnames cmps imports inclusions
                                items
                                /*
                                symbols axioms definitions adts
                                signatures assertions exercises
                                presentations textitems omgroups privates
                                */]) 
end

meth writeSymbol(X)
   Self, writeTaggedItem(X order:[metadata cmps commonnames types selectors]
                         attribs:[id kind scope])
end

/*
meth writeCommonname(X) % commonname(string:  'xml:lang':)
   Self, tag(commonname(X.string /*mid:X.mid*/ 'xml.lang':X.'xml:lang'))
end
*/

meth writeCommonname(X) % commonname(string:  'xml:lang':)
   Self, writeTaggedItem(X attribs:[mid 'xml:lang'] order:[string])
end

meth writeSignature(X)
   {self emptyTag(X)}
end

meth writeType(X)
   Self, writeTaggedItem(X order:[omobj] 
                         attribs:[system mid])
end

meth writeAxiom(X)
   Self, writeTaggedItem(X order:[metadata symbols cmps fmp] 
                         attribs:[id])
end

meth writeDefinition(X)
   Self, writeTaggedItem(X order:[metadata cmps fmps requations omobjs]
                         attribs:['just-by' type id])
end

meth writeRequation(X)
   Self, writeTaggedItem(X order:[pattern value] attribs:[mid])
end

meth writePattern(X)
   Self, startTag('pattern')
   OmobjWriter, writeElem(X)
   Self, endTag('pattern')
end

meth writeValue(X)
   Self, startTag('value')
   OmobjWriter, writeElem(X)
   Self, endTag('value')
end

meth writeAdt(X)
   Self, writeTaggedItem(X attribs:[type id]
                         order:[metadata commonnames sortdefs])
end

meth writeSortdef(X)
   Self, writeTaggedItem(X order:[symbols insorts] attribs:[id])
end

meth writeConstructor(S)
   Self, writeTaggedItem(S order:[commonname argument] attribs:[id])
end

meth writeArgument(X)
   Self, writeTaggedItem(X attribs:[sort])
end

meth writeInsort(X)
   {self emptyTag(X attribs:[id])} 
end

meth writeSelector(X)
   Self, writeTaggedItem(X attribs:[id type]) %  no order (single-element) 
end

meth writeImport(X) % was: writeImports 
   Self, writeTaggedItem(X
                         order:[cmps morphism]
                         attribs:[id 'from' type])
end

meth writeMorphism(X)
   Self, writeTaggedItem(X
                         order:[requations]
                         attribs:[id base])
end

meth writeInclusion(I)
   {self emptyTag(I)}     % Since there are no integer features any more,
                          % all features are taken to be attributes here. 
end
