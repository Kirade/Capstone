import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileManager
 */
@WebServlet("/FileManager")
public class FileManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String filename = request.getParameter("filename");
		
		String saveDir = this.getServletContext().getRealPath("/upload/");
		File file = new File(saveDir + "/" + filename);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null)
			response.setContentType("application/octet-stream");
		
		String downName = null;
		if(request.getHeader("user-agent").indexOf("MSIE")==-1)
			downName = new String(filename.getBytes("utf-8"), "8859_1");
		else
			downName = new String(filename.getBytes("utf-8"), "8859_1");
		
		response.setHeader("Content-Disposition", "attachment);filename=\"" + downName + "\";");
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data=0;
		
		while((data=(fileInputStream.read(b, 0, b.length))) != -1){
			servletOutputStream.write(b, 0, data);
		}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
			
	}

}
