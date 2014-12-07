functor
import
   Xml('class':XML) at 'x-ozlib://mathweb/omdoc/out/xml.out.ozf'
% Buffered
   
   OMOBJ('class':OmobjWriter)
   at 'x-ozlib://mathweb/omdoc/out/omobj.out.ozf'
   
   METADATA('class':MetadataWriter)
   at 'x-ozlib://mathweb/omdoc/out/metadata.out.ozf'
   
   Browser(browse:Browse)
   System
export
   'class': OmdocWriter

define

   %%
   %% from omdocmath.out.oz:
   %%
%  MATHITEM = [assertion 'alternative-def' example 'theory-inclusion'
%              proof proofobject]
   CF = [symbols cmps fmps]
   CFM = [metadata symbols cmps fmps]
   
   class Self = OmdocWriter
      from
         XML
         OmobjWriter
         MetadataWriter
         
      meth write(vs:VS)
         {System.showInfo VS}
      end
      /*
      meth writeOmdocItem(X)
         C|Sr = {AtomToString {Label X}}
         L = {StringToAtom {Char.toUpper C}|Sr}
      in
         {self tag({Adjoin X L})}         
      end
      */
      meth writeGeneric(X)
	 L = {Label X} in
	 case X of L(MID) andthen {IsInt MID} then
	    {self emptyTag(L(mid:MID))}
	 else
	    C|Sr = {AtomToString L}
	    Meth = {VirtualString.toAtom "write"#({Char.toUpper C}|Sr)}
	 in
	    {self Meth(X)}
	 end
      end
      meth writeOmobj(X)
	 case X of nil then skip
         else
	    OmobjWriter, writeOMOBJ(X)
	 end
      end
      meth writeTaggedItem(ItemRecord
			   order: OrderedItemNames
                           %%<=
			   %%{List.filter {Record.arity ItemRecord}
                           %% fun{$ I}
                           %%    {Member I Attribs} == false
                           %% end}
                           %% Im ungeordneten Fall: alle Features ausser Attributen
			   attribs: Attribs <= nil)
	 Self, startTag(ItemRecord attribs:Attribs)
	 {ForAll OrderedItemNames
          proc{$ F}
             Self, writeElems(F {CondSelect ItemRecord F unit})
          end}
	 Self, endTag(ItemRecord)
      end  

      \insert omdocmath.out.oz
      \insert omdoctheory.out.oz
      \insert omdocaux.out.oz
      
      meth writeOmdoc(X)
	 Self, writeTaggedItem(X attribs:[id mid type]
                               order:[metadata items
                                      /*
                                      omtexts assertions
                                      'alternative-defs' examples
                                      'theory-inclusions' 'axiom-inclusions'
                                      proofs proofobjects
                                      */])
      end
      
      meth writeOmgroup(X)
	 Self, writeTaggedItem(X attribs:[type id]
                               order:[metadata omgroups refs])
      end
      
      meth writeRef(X)
	 Self, emptyTag(X attribs:[mid id xref]) 
      end
	 
      meth writeTref(X)
	 Self, emptyTag(X attribs:[theory name])
      end

      %%
      %% omdoctext
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

      %%
      %% main dispatch
      %%
      
      meth writeElems(Kind Content)
         
	 proc {ForAllContent WriteMethod}
	    {ForAll Content
             proc{$ CN}
                Self, WriteMethod(CN)
             end}
	 end
      in
	 if Content == unit then skip
	 else 
	    case Kind
	    of omdoc then Self, writeOmdoc(Content)
	    [] omgroup then Self, writeOmgroup(Content)
	    [] ref then Self, writeRef(Content)
	    [] tref then Self, writeTref(Content)
	    [] omtexts then {ForAllContent writeOmtext}
	    [] assertions then {ForAllContent writeAssertion}
	    [] 'alternative-defs' then {ForAllContent writeAlternativedef} % Name???
	    [] examples then {ForAllContent writeExample}
	    [] 'theory-inclusions' then {ForAllContent writeTheoryinclusion} % ??
	    [] 'axiom-inclusions' then {ForAllContent writeAxiominclusion}   % ??
	    [] proofs then {ForAllContent writeProof}
	    [] proofobjects then {ForAllContent writeProofObject}
	    [] omgroups then {ForAllContent writeOmgroup}
	    [] refs then {ForAllContent writeRef}
               
%%% from omdoctext
            [] cmps then {ForAllContent writeCmp}
            [] items then {ForAllContent writeGeneric /*writeItem*/} % hack
            [] lists then {ForAllContent writeList}
            [] omobjs then {ForAllContent writeOmobj}
            [] omlets then {ForAllContent writeOmlet}
            [] metadata then MetadataWriter, writeMetadata(Content)

%%% from omdocmath

            [] fmps then {ForAllContent writeFmp}
            [] fmp then Self, writeFmp(Content)
            [] assertion then Self, writeAssertion(Content)
            [] assumptions then {ForAllContent writeAssumption}
            [] conclusion then Self, writeConclusion(Content)
            [] 'alternative-def' then Self, 'writeAlternative-def'(Content)
            [] proof then Self, writeProof(Content)
            [] proofobject then Self, writeProofobject(Content)
            [] metacomments then {ForAllContent writeMetacomment}
            [] derives then {ForAllContent writeDerive}
            [] conclude then Self, writeConclude(Content)
            [] hypotheses then {ForAllContent writeHypothesis}
            [] method then Self, writeMethod(Content)
            [] parameters then {ForAllContent writeParameter}
            [] premises then {ForAllContent writePremise}
            [] example then Self, writeExample(Content)
            [] 'axiom-inclusion' then Self, 'writeAxiom-inclusion'(Content)
            [] 'theory-inclusion' then Self, 'writeTheory-inclusion'(Content)
            [] 'path-just' then Self, 'writePath-just'(Content)
            [] 'assertion-just' then Self, 'writeAssertion-just'(Content)
            [] decomposition then Self, writeDecomposition(Content)

            [] omstr then {Browse need_method#writeOmstr}
               %%{self writeOmstr(Content)}
       
%%% from omdoctheory
               
            [] symbols then {ForAllContent writeSymbol}
            [] commonnames then {ForAllContent writeCommonname}  
            [] signatures then {ForAllContent writeSignature}
            [] types then {ForAllContent writeType}
            [] axioms then {ForAllContent writeAxiom}
            [] definitions then {ForAllContent writeDefinition} 
            [] requations then {ForAllContent writeRequation}
            [] pattern then Self,  writePattern(Content)
            [] value then Self,  writeValue(Content)
            [] adts then {ForAllContent writeAdt}
            [] sortdefs then {ForAllContent writeSortdef}
            [] insorts then {ForAllContent writeInsort}
            [] selectors then {ForAllContent writeSelector}	    
            [] imports then {ForAllContent writeImport}
            [] morphism then Self, writeMorphism(Content)
            [] inclusions then {ForAllContent writeInclusion}
               
	    [] omobj then {self writeOmobj(Content)} %was: writeOmObj %noetig???
	    [] 'OMOBJ' then {self writeOmobj(Content)} %was: writeOmObj
            [] exercises then {ForAllContent writeExercise}
            [] presentations then {ForAllContent writePresentation}
            [] textitems then {ForAllContent writeOmtext}
            [] privates then {ForAllContent writePrivate}
            [] arguments then {ForAllContent writeArgument}
            [] oma then {self writeOma(Content)} % where is this used?
            [] oms then {self writeOms(Content)} % where is this used?
               
%%% from omdocaux
               
            [] hint then Self, writeHint(Content)
            [] solutions then Self, writeSolution(Content)
            [] mcs then {ForAllContent writeMc} % was: Self, writeMc(Content)
            [] 'choice' then Self, writeChoice(Content) 
            [] answer then Self, writeAnswer(Content)
            [] data then Self, writeData(Content)
            [] input then Self, writeInput(Content)
            [] output then Self, writeOutput(Content)
            [] effect then Self, writeEffect(Content)
            [] use then Self, writeUse(Content)
               
%%% writeElems: what about the (unknown) features of e.g data ???
%%% either return them in else case or name them explicitly []
	    [] content then {self writeContent(Content)}
	       
%% Hack, zum Ausgeben von Commonname:
	    [] string then
	      % {Browse Content}
	       [ToBeWritten] = Content
	    in
	       {self write(vs:ToBeWritten)}
            else Self, write(vs:"Dunno!!!" /*Content*/)              
	    end
	 end
      end
   end
end
            



