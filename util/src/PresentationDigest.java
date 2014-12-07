

import java.io.*;
import org.apache.regexp.RE;
import org.apache.regexp.RESyntaxException;


public class PresentationDigest implements Runnable {

	public static void main(String[] args) {
		System.out.println("<?xml version=\"1.0\"?>");
		System.out.println("<!DOCTYPE omdoc");
		System.out.println(" SYSTEM 'http://www.mathweb.org/omdoc/dtd/omdoc.dtd'");
		System.out.println(" [");
		System.out.println("<!ENTITY amp '&amp;#38;#38;'>");
		System.out.println("<!ENTITY lt '&amp;#38;#60;'>");
		System.out.println("<!ENTITY apos '&amp;#39;'>");
		System.out.println("<!ENTITY quot '&amp;#34;'>");
		System.out.println("<!ENTITY gt '&amp;#62;'>");
		System.out.println("]>");
		System.out.println("<omdoc>");
		PresentationDigest p = new PresentationDigest();
		p.run();
		System.out.println("</omdoc>");
		if ( p.exception == null ) System.exit(0);
			else System.exit(1);
		}

	public final boolean DEBUG = false;
	public final RE re_theoryID;
	public final RE re_grepResultLine;
	public final RE re_startPresentTag, re_endPresentTag;

	public PresentationDigest () {
	// ================
		try {
			re_grepResultLine = new RE("^(.*):([:digit:]+):(.*)$");
			re_theoryID = makeTagAndAttributeRE("theory", "id");
			re_startPresentTag = new RE("(<presentation .*$)");
			re_endPresentTag = new RE("(^.*</presentation>)");
			} catch (Exception e) { e.printStackTrace(); 
				throw new RuntimeException("Trouble with REs : " + e.getMessage()); }
		}
	

	String currentTheory = null;
	String dateString = null ;

	public void run() {
		try {
			dateString = System.currentTimeMillis() + " i.e. " + new java.util.Date().toString();
			DataInputStream in = new DataInputStream(System.in);
			String line;
			int presentationStart = -1 ;
			while ( ( line = in.readLine() ) != null ) {
				if ( line.length() > 2 &&  line.charAt(0)==' ' && line.equals(" ===== :00: ===== finished")) break;
				if ( line.indexOf(const_startTheory)!=-1) { // a theory start ??? any other syntax
					if ( DEBUG) System.err.println("]]]] A start theory.");
					currentTheory = readTheoryID(line);
					}
				else if ( line.indexOf(const_endTheory) != -1 ) {
					if ( DEBUG)  System.err.println("]]]] An end theory.");
					currentTheory = null; }
				else if ( line.indexOf(const_startPresentation ) != -1 ) {
					presentationStart = resultReadLineNumber(line);
					if ( DEBUG) System.err.println("]]]] A start presentation.");
					}
				else if ( line.indexOf(const_endPresentation ) != -1 ) {
					if ( DEBUG) System.err.println("]]]] An end presentation.");
					String fileName = resultReadFileName(line);
					String presentationLines = readLines( 
						fileName, presentationStart, re_startPresentTag,
						resultReadLineNumber(line), re_endPresentTag);
					feedTemplate(presentationLines, currentTheory, fileName);
					}
				}
			} catch (Exception e) {
				this.exception = e;
				e.printStackTrace();
				}			
		}
	
	public Exception exception = null;
	
	/** This is where everything is fed through ! */
	public void feedTemplate (String lines, String theory, String omdocPath) {
	// ===============
		//System.out.println("============================= in theory " + possibleMissingTheory + " in file " + omdocPath + " ================");
		System.out.print("<!-- Created from OMdoc ");System.out.print(omdocPath); 
		System.out.print(" at "); System.out.print( dateString ); System.out.println(" -->");
		if (theory != null )
			{System.out.print("<theory id=\"");System.out.print(theory); System.out.println("\">");}
		System.out.println(lines);
		if ( theory != null)
			System.out.println("</theory>");
		}



	public LineNumberReader currentLineReader = null;
	public String currentLineReaderFile = null ;
	/** 
		This reads the line from the given file, re-opening the lineReader of it only if needed.
		It reads from the <code>start</code> line number to the </code>end</code> line number
		and filters the first line by exatracting from the first line, the first paren for <code>startPat</code>
		and on last line (the given line number for end), the first paren of <code>endPath</code>
		*/
	public String readLines(String file, int start, RE startPat, int end, RE endPat) throws IOException {
	// ---------------------
		if ( ! file.equals(currentLineReaderFile) 
				|| currentLineReader.getLineNumber() > start ) {
			try { currentLineReader.close(); } catch ( Exception ex) {}
			currentLineReader = new LineNumberReader( new FileReader(file) );
			currentLineReaderFile = file;
			}
		while ( currentLineReader.getLineNumber()+1 < start ) {
			currentLineReader.readLine();
			} // this stops when the line number is start -1
		StringBuffer buff = new StringBuffer ( (end-start)* 20 );
		String line = currentLineReader.readLine();
		startPat.match(line); buff.append(startPat.getParen(1));
		buff.append('\n');
		// loop to digest lines that need not be matched.
		while ( currentLineReader.getLineNumber()+1 < end ) {
			buff.append( currentLineReader.readLine() );
			buff.append('\n');
			}
		endPat.match(currentLineReader.readLine()); buff.append(endPat.getParen(1) );
		buff.append('\n');
		return  buff.toString();
		}
	
/*	public static int resultReadLineNumber(String line) {
	// ------------------------------------
		if ( line == null ) return -1;
		int a = line.indexOf(":");
		if ( a ==  -1 || a+1 >= line.length() ) return -1;
		int b = line.indexOf(":", a+1);
		if ( b == -1 || a<= b ) return -1;
		try {
			return  Integer.parseInt( line.substring(a+1, b) );
			}
			catch (NumberFormatException ex) { return -1; }
		}
	
*/	
	

	/** Reads, in a line, like <code>file/Name/blop.omblop:xx:&lt;theory id=""&gt;</code>", the value of the ID atttribute.
		Returns null if it is not found. */
	public String readTheoryID ( String line) {
	// -------------------------
		if ( line == null || line.length() == -1 ) return null;
		synchronized(re_theoryID) {
			re_theoryID.match(line);
			String paren4 = re_theoryID.getParen(4);
			if ( paren4 != null )
				return paren4;
			else return re_theoryID.getParen(5);
			}
		}
		
	/** Variable for optimization.... avoids the rematch if the line is the same (very probable). */
	public String currentLine;

	/** @returns the  Matching result, if there was a match, true otherwise. */
	protected boolean matchIfNeeded(String line) {
	// ===================
		if ( currentLine != line ) {
			currentLine = line;
			return re_grepResultLine.match(line);
			}
		return true;
		}
	
	/** Reads, in a line, like <code>file/Name/blop.omblop:xx:theLine</code>", the <code>xx</code> that is, the lineNumber.
		Returns -1 if it is not found. */
	public int resultReadLineNumber(String line) {
	// =======================
		synchronized ( re_grepResultLine ) {
			if ( matchIfNeeded(line) == false ) return -1;
			try {
				return  Integer.parseInt( re_grepResultLine.getParen(2) );
				}
				catch (NumberFormatException ex) { return -1; }
			}
		}
	
	public String resultReadFileName(String line)  {
	// =====================
		synchronized ( re_grepResultLine ) {
			if ( matchIfNeeded(line)  == false ) return null;
			return re_grepResultLine.getParen(1);
			}
		}

		
	
	/** Builds an RE object whose {@link RE.getParen}(1) will be the tag's name and the  4 or 5 (depending on the quotes used)
		will be the attribute value. The string chosen for tagName and attributename can be regexps.*/
	public static RE makeTagAndAttributeRE(String tagName, String attributeName) throws RESyntaxException {
	// -------------------------------------------------
		RE r = new RE("<(" + tagName + ")[:space:][^>]*("
			+ attributeName + ")[:space:]*=[:space:]*(\"([^\"]*)\"|'([^']*)')"); 
		return r;
		}
	
	public static final String
		const_startTheory = "<theory",
		const_endTheory = "</theory>",
		const_startPresentation = "<presentation",
		const_endPresentation = "</presentation>";
	
	}