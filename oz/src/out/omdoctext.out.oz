%%
%% omdoctext writer (include file)
%%

meth writeOmtext(X)
   Self, writeTaggedItem(X attribs:[id mid type 'for' 'from']
                         order:[metadata cmps])
end

meth writeList(Xs)
   Self, writeTaggedItem(Xs attribs:[id mid]
                         order:[items])
end

meth writeItem(X)
   Self, writeTaggedItem(X attribs:[id mid]
                         order:[metadata cmps])
end

meth writeCmp(X)
   Self, writeTaggedItem(X attribs:['xml:lang']
                         order:[content])
end

meth writeContent(X)
   /*
   fun {IsSimple1 X}
      case {Value.type X}
      of atom then true
      [] int then true
      [] float then true
      [] byteString then true
      elsecase X of '|'(_ _) then true
      else false
      end
   end
in
   */
   case X of '#'(...) then
      {Record.forAll X proc {$ Y} Self, writeContent(Y) end}
   elseif {IsVirtualString X} then
      {self write(vs:X)}
   elsecase X of nil then skip
   [] '|'(Head Tail) then
      Self, writeContent(Head)
      Self, writeContent(Tail)
   [] 'OMOBJ'(...) then
      OmobjWriter, writeOMOBJ(X)
   [] list(...) then
      Self, writeList(X)
   else
      VS = {Value.toVirtualString X 1000 1000} in
      {self write(vs:VS)}
   end
end
