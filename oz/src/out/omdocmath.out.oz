%%
%% omdocmath writer (include file)
%%

% defined in omdoc.out.oz:
%
% MATHITEM = [assertion 'alternative-def' example 'theory-inclusion'
%             proof proofobject]
% CF = [symbols cmps fmps]
% CFM = [metadata symbols cmps fmps]

meth writeFmp(X)
   Self, writeTaggedItem(X attribs:[logic mid]
                         order:[assumptions conclusion omobj])
end

meth writeAssertion(X)
   Self, writeTaggedItem(X attribs:[theory type id mid]
                         order:CFM)
end

meth writeAssumption(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps omobj])
end

meth writeConclusion(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps omobj])
end

meth 'writeAlternative-def'(X)
   Self, writeTaggedItem(X attribs:[id mid theory]
                         order:[metadata cmps fmps requations omobj])
end

meth writeProof(X)
   Self, writeTaggedItem(X attribs:[theory id mid]
                         order:[metadata symbols cmps metacomments derives
                                hypotheses conclude] )
end

meth writeProofobject(X)
   Self, writeTaggedItem(X attribs:[theory id mid]
                         order:[cmps omobj])
end

meth writeMetacomment(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps])
end

meth writeDerive(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps fmp method premises proof proofobject])
end

meth writeConclude(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[cmps method premises proof proofobject])
end

meth writeHypothesis(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:CF)
end

meth writeMethod(X)
   Self, writeTaggedItem(X order:[tref omstr parameters])
end

meth writeParameter(X)
   Self, writeTaggedItem(X order:[omobj])
end

meth writePremise(X)
   {self emptyTag(X attribs:[href])}
end

meth writeExample(X)
   Self, writeTaggedItem(X attribs:[type id mid item assertion proof]
                         order:[metadata symbols cmps omobj])
end

meth 'writeAxiom-inclusion'(X)
   Self, writeTaggedItem(X attribs:[id mid 'from' to timestamp]
			 order:[metadata morphism /* 'path-just' 'assertion-just'*/])
                                         %our theories are not yet up to the new dtds ... 
end

meth 'writeTheory-inclusion'(X)
   Self, writeTaggedItem(X attribs:[id mid 'from' to by timestamp]
                         order:[metadata morphism decomposition])
end

meth 'writePath-just'(X)
   {self emptyTag(X attribs:[timestamp 'local' globals mid])}
end

meth 'writeAssertion-just'(X) 
   {self emptyTag(X attribs:[timestamp  ids mid])}
end

meth writeDecomposition(X)
   {self emptyTag(X attribs:[timestamp links id mid])}
end
