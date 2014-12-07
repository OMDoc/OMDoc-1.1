%%
%% xml pretty-printer
%%

functor
   
import
   XmlPrinter('class': XML)
   at 'x-ozlib://mathweb/share/XmlPrinter.ozf'
   
export
   'class': PrettyPrinter

define
   
   %%
   %% write OpenMath objects
   %%
   local
      skip
   in
      class Self = PrettyPrinter
         from XML
            
	 attr
            indent: false
            prefix: ''
	    tab:    '  '
	    
	 meth init(prefix: Prefix <= "\n"
		   tab:    Tab    <= "  "
                   indent: Indent <= true)
	    prefix <- Prefix
	    tab    <- Tab
            indent <- Indent
	 end
         %%
         meth indentOn
            indent <- true
         end
         meth indentOff
            indent <- false
         end
         %%
	 meth setPrefix(Prefix)
	    prefix <- Prefix
	 end
         %%
         meth setTab(N)
	    Tab = {List.make N} in
	    {ForAll Tab proc {$ C} C=&  end}
	    tab <- Tab
	 end
         meth pushTab(Tab<=@tab)
	    prefix <- @prefix#Tab
	 end
	 meth popTab
	    Prefix#_ = @prefix in
	    prefix <- Prefix
	 end
         %%
         meth writePrefix
            if @indent then {self write(vs:@prefix)} end
         end
	 /*
	 meth writePrefix1
	    if @indent then {self write(vs:@prefix#@tab)} end
	 end
	 */
         %%
         meth startTag(/*indent:Indent<=true*/...) = StartTag
            /*if Indent then*/ Self, writePrefix /*end*/
            %% hack for Al's OmdocWriter
            case StartTag of startTag(R attribs:Attribs) then
               Attribs1 = {Filter Attribs fun {$ F} {HasFeature R F} end} in
               XML, startTag(R attribs:Attribs1)
            else
               XML, StartTag
	    end
	    Self, pushTab
         end
	 meth endTag(indent:Indent<=true...) = EndTag
	    Self, popTab
	    if Indent then Self, writePrefix end
            XML, {Record.subtract EndTag indent}
         end
         meth emptyTag(...) = EmptyTag
	    Self, writePrefix
            XML, EmptyTag
	 end
	 /*
	 meth tag(T)
	    Self, writePrefix
	    XML, startTag(T)
	    {ForAll {Filter {Arity T} IsInt}
	     proc {$ I}
		XML, tag(T.I)
	     end}
	    XML, endTag(T)
	 end
	 */
	 %%   
         meth writeElems(L)
            {ForAll L
	     proc {$ Elem}
		{self writeElem(Elem)}
	     end}
         end
      end
   end
end



