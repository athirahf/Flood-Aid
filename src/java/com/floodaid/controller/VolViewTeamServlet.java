
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.floodaid.model.Volunteer;
import com.floodaid.model.VolunteerDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

@WebServlet("/VolViewTeamServlet")
public class VolViewTeamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("userID") == null) {
        response.sendRedirect("pages-login.html?error=session_expired");
            return;
    }
    
    int userID = (int) session.getAttribute("userID");

    VolunteerDAO volunteerDAO = new VolunteerDAO();
    List<Volunteer> volunteerList = volunteerDAO.getVolunteersByCurrentUser(userID);
    int userShelterID = volunteerDAO.getShelterIDByUserID(userID);
    String userShelterName = volunteerDAO.getShelterName(userShelterID);

    // Log the volunteer list for debugging
    System.out.println("Volunteers List: " + volunteerList);
    if (volunteerList != null) {
        System.out.println("Number of Volunteers: " + volunteerList.size());
    } else {
        System.out.println("Volunteer List is null");
    }

    if (volunteerList == null) {
        volunteerList = new ArrayList<>();
    }

    request.setAttribute("volunteers", volunteerList);
    request.setAttribute("shelterName", userShelterName);
    RequestDispatcher dispatcher = request.getRequestDispatcher("volunteer-viewteam.jsp");
    dispatcher.forward(request, response);
}}

