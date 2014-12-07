%%%
%%% kqml parser semantics
%%%

declare F in F =

functor

import
   X('class': SemOMObj) at 'omdobj.sem.ozf' % what about omdoc ???
   
export
   'class': SemKQML

define

   fun {Default E}
      {AdjoinAt E.attribs content E.content}
   end
   
   class SemKQML
      from SemOMObj % what about omdoc ???
      %% DTD for OpenMath KQML - MiKo 21.7.99

      %% <!-- we first import the OMDOC DTD, this includes the OpenMath object dtd -->
      %% <![%net;[<!ENTITY  % omdocdtd SYSTEM "http://www.ags.uni-sb.de/~omega/www/projects/openmath/omdoc/omdoc.dtd">]]>
      %% <![%local;[<!ENTITY  % omdocdtd SYSTEM "omdoc.dtd">]]>
      %% %metadatadtd;

      %% <!-- to have some standard ontologies, we import the core CDs, the contributed CDs 
      %%      and the KQML ontology -->
      %% <!ENTITY omcorecds "http://www.nag.co.uk/projects/OpenMath/corecd">
      %% <!ENTITY omcontribcds  "http://www.nag.co.uk/projects/OpenMath/contrib">
      %% <!ENTITY kqml-ontology "http://www.ags.uni-sb.de/~kohlhase/openmath/kqml">

      %% <!-- finally, we provide the language definition in this DTD as an abbreviation -->
      %% <!ENTITY kqml-dtd "http://www.ags.uni-sb.de/~kohlhase/openmath/kqml">

      %% <!ENTITY % disc-performative " tell | deny | untell | delete | delete-one 
      %% 			      | error | sorry  | evaluate | reply 
      %% 			      | ask-about  | stream-about | eos | unachieve
      %% 			      | standby | ready | next | rest | discard | generator
      %% 			      | advertise | monitor | pipe | break">
      %% <!-- the discourse performatives that cannot be advertised -->

      %% <!ENTITY % adv-performative " ask-if | ask-one | ask-all | stream-all 
      %%                              | insert | uninsert | delete-all | achieve | subscribe">
      %% <!-- the discourse performatives that can be advertised. -->

      %% <!ENTITY % fac-performative " register | unregister | transport-address | forward
      %%                              | broadcast | broker-one | broker-all 
      %% 			     | recommend-one | recommend-all
      %% 			     | recruit-one | recruit-all">

      %% <!ENTITY % response-performative "ask-if | ask-all | ask-one | stream-all |
      %%                                   subscribe | recommend-one | recommend-all">

      %% <!ENTITY % performative "%disc-performative; | %adv-performative; | %fac-performative;">

      %% <!ENTITY % msg-att "sender      CDATA  #REQUIRED
      %%  	            receiver    CDATA  #REQUIRED
      %%    	            reply-with  CDATA  #REQUIRED">

      %% <!ENTITY % msgir-att "%msg-att;  
      %%                       in-reply-to CDATA  #REQUIRED">
      %% <!ENTITY % msgii-att "%msg-att;  
      %%                       in-reply-to CDATA  #IMPLIED">

      %% <!ENTITY % lang-att "language CDATA  #REQUIRED
      %%    	             ontology CDATA  #REQUIRED">

      %% <!ENTITY % full-att "%msgir-att; %lang-att;">
      %% <!ENTITY % fullii-att "%msgii-att; %lang-att;">

      %% <!ENTITY % to-att "to   CDATA  #REQUIRED
      %%    	           from CDATA  #REQUIRED">
	         
      %% <!-- the kqml top node -->
      %% <!ELEMENT kqml (%performative;)*>
      meth 'make_kqml'(E $)
         'kqml'(E.content)
      end

      %% <!-- the performatives 
      %%      they the content is in the body, -->

%%% Discourse performatives
      
%%% This is the category of performatives that may be considered as 
%%% close as possible to speech acts in the linguistic sense. Of course 
%%% the idea of explicitly stating the format of the response (as in stream-all
%%% or ask-one) is unusual from a speech act theory perspective, 
%%% but they may still be considered as speech acts in the pure sense. 
%%% These are the performatives to be used in the context of an information
%%% and knowledge exchange kind of discourse between two agents. -->

      %% <!ELEMENT ask-if (%omel;)>
      %% <!ATTLIST ask-if %fullii-att;>
      meth 'make_ask-if'(E $)
         {Default E}
      end

      %% <!ELEMENT ask-all (%omel;)>
      %% <!ATTLIST ask-all %fullii-att;>
      meth 'make_ask-all'(E $)
         {Default E}
      end

      %% <!ELEMENT ask-one (%omel;)>
      %% <!ATTLIST ask-one %fullii-att;>
      meth 'make_ask-one'(E $)
         {Default E}
      end

      %% <!ELEMENT stream-all (%omel;)>
      %% <!ATTLIST stream-all %full-att;>
      meth 'make_stream-all'(E $)
         {Default E}
      end

      %% <!ELEMENT eos EMPTY>
      %% <!ATTLIST eos %msgir-att;>
      meth 'make_eos'(E $)
         {Default E}
      end

      %% <!ELEMENT tell (%omel;)*>
      %% <!ATTLIST tell %fullii-att;>
      meth 'make_tell'(E $)
         {Default E}
      end

      %% <!ELEMENT untell (%omel;)*>
      %% <!ATTLIST untell %full-att;>
      meth 'make_untell'(E $)
         {Default E}
      end

      %% <!ELEMENT deny (%omel;)*>
      %% <!ATTLIST deny %full-att;>
      meth 'make_deny'(E $)
         {Default E}
      end

      %% <!ELEMENT insert (%omel;)*>
      %% <!ATTLIST insert %fullii-att;>
      meth 'make_insert'(E $)
         {Default E}
      end

      %% <!ELEMENT uninsert (%omel;)*>
      %% <!ATTLIST uninsert %full-att;>
      meth 'make_uninsert'(E $)
         {Default E}
      end

      %% <!ELEMENT delete-one (%omel;)>
      %% <!ATTLIST delete-one %fullii-att;>
      meth 'make_delete-one'(E $)
         {Default E}
      end

      %% <!ELEMENT delete-all (%omel;)>
      %% <!ATTLIST delete-all %fullii-att;>
      meth 'make_delete-all'(E $)
         {Default E}
      end

      %% <!ELEMENT undelete (%omel;)>
      %% <!ATTLIST undelete %full-att;>
      meth 'make_undelete'(E $)
         {Default E}
      end

      %% <!ELEMENT achieve (%omel;)>
      %% <!ATTLIST achieve %fullii-att;>
      meth 'make_achieve'(E $)
         {Default E}
      end

      %% <!ELEMENT unachieve (%omel;)>
      %% <!ATTLIST unachieve %full-att;>
      meth 'make_unachieve'(E $)
         {Default E}
      end

      %% <!ELEMENT advertise (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST advertise %msg-att; %lang-att;>
      meth 'make_advertise'(E $)
         {Default E}
      end
      
      %% <!ELEMENT unadvertise (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST unadvertise %full-att;>
      meth 'make_unadvertise'(E $)
         {Default E}
      end

      %% <!ELEMENT subscribe (%response-performative;)>
      %% <!ATTLIST subscribe %fullii-att;>
      meth 'make_subscribe'(E $)
         {Default E}
      end

%%% 4.2 Intervention and mechanics of conversation performatives 

%%% The role of those performatives is to intervene in the normal course of a
%%% conversation. The normal course of a conversation is as follows: agent A
%%% sends a KQML message (thus starting a conversation) and agent B responds
%%% whenever it has a response or a follow-up. The performatives of this
%%% category, either prematurely terminate a conversation (<error>, <sorry>),
%%% or override this default protocol (<standby>, <ready>, <next>, <rest> 
%%% and <discard>).

      %% <!ELEMENT error EMPTY>
      %% <!ATTLIST error %msgir-att;>
      meth 'make_error'(E $)
         E.attribs
      end

      %% <!ELEMENT sorry EMPTY>
      %% <!ATTLIST sorry %msgir-att;>
      meth 'make_sorry'(E $)
         E.attribs
      end

      %% <!ELEMENT standby (%response-performative;)>
      %% <!ATTLIST standby %fullii-att;>
      meth 'make_standby'(E $)
         {Default E}
      end
      
      %% <!ELEMENT ready EMPTY>
      %% <!ATTLIST ready %msgir-att;>
      meth 'make_ready'(E $)
         E.attribs
      end

      %% <!ELEMENT next EMPTY>
      %% <!ATTLIST next %msgir-att;>
      meth 'make_next'(E $)
         E.attribs
      end

      %% <!ELEMENT rest EMPTY>
      %% <!ATTLIST rest %msgir-att;>
      meth 'make_rest'(E $)
         E.attribs
      end

      %% <!ELEMENT discard EMPTY>
      %% <!ATTLIST discard %msgir-att;>
      meth 'make_discard'(E $)
         E.attribs
      end
      
%%% 4.3 Networking and Facilitation performatives
      
%%% The performatives of this category are not speech acts in the pure
%%% sense. They are primarily performatives that allow agents to find other
%%% agents that can process their queries. Although regular, non-facilitator
%%% agents could choose to process them, it would not be particularly helpful
%%% since the facilitation performatives rely on advertise messages and only
%%% facilitators have the power to make advertise messages community-wide.

      %% <!ELEMENT register (#PCDATA)>
      %% <!ATTLIST register %full-att;>
      meth 'make_register'(E $)
         {Default E}
      end

      %% <!ELEMENT unregister EMPTY>
      %% <!ATTLIST unregister %msgir-att;>
      meth 'make_unregister'(E $)
         E.attribs
      end

      %% <!ELEMENT transport-address (#PCDATA)>
      %% <!ATTLIST transport-address %full-att;>
      meth 'make_transport-address'(E $)
         {Default E}
      end

      %% <!ELEMENT forward (%performative;)>
      %% <!ATTLIST forward %to-att; %fullii-att;>
      meth 'make_forward'(E $)
         {Default E}
      end

      %% <!ELEMENT broadcast (%performative;)>
      %% <!ATTLIST broadcast %full-att;>
      meth 'make_broadcast'(E $)
         {Default E}
      end

      %% <!ELEMENT broker-one (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST broker-one %fullii-att;>
      meth 'make_broker-one'(E $)
         {Default E}
      end

      %% <!ELEMENT broker-all (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST broker-all %fullii-att;>
      meth 'make_broker-all'(E $)
         {Default E}
      end

      %% <!ELEMENT recommend-one (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST recommend-one %fullii-att;>
      meth 'make_recommend-one'(E $)
         {Default E}
      end

      %% <!ELEMENT recommend-all (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST recomment-all %fullii-att;>
      meth 'make_recommend-all'(E $)
         {Default E}
      end

      %% <!ELEMENT recruit-one (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST recruit-one %fullii-att;>
      meth 'make_recruit-one'(E $)
         {Default E}
      end
      
      %% <!ELEMENT recruit-all (%adv-performative; | %fac-performative;)>
      %% <!ATTLIST recruit-all %fullii-att;>
      meth 'make_recruit-all'(E $)
         {Default E}
      end

      %%
      %% fallback
      %%
      meth otherwise(M)
         M.2={Default M.1}
      end
   end
   
end






