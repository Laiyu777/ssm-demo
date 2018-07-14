
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;

import java.io.File;
import java.io.IOException;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.BoxLayout;
import javax.swing.filechooser.FileSystemView;
import sun.awt.shell.ShellFolder;

public class FileIconExtractor extends JFrame implements ActionListener
{
    /**
     * {字段功能描述}
     */
    private static final long serialVersionUID = 1L;

    private JButton getIconBtn = new JButton("get Icon");

    private JPanel iconPanel = new JPanel();

    private JTextField extField = new JTextField();

    private JLabel smallIconLabel = new JLabel("small Icon here");

    private JLabel bigIconLabel = new JLabel("big Icon here");

    public FileIconExtractor()
    {
        this.setSize(200, 150);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setLayout(new BorderLayout());
        getIconBtn.setActionCommand("GETICON");
        getIconBtn.addActionListener(this);
        iconPanel.setLayout(new BoxLayout(iconPanel, BoxLayout.Y_AXIS));
        iconPanel.add(smallIconLabel);
        iconPanel.add(bigIconLabel);
        this.add(extField, BorderLayout.NORTH);
        this.add(iconPanel, BorderLayout.CENTER);
        this.add(getIconBtn, BorderLayout.SOUTH);
        this.setVisible(true);
    }

    public void actionPerformed(ActionEvent e)
    {
        if (e.getActionCommand().equals("GETICON"))
        {
            String ext = extField.getText();
            File file;
            try
            {
                file = File.createTempFile("icon", "." + ext);
                FileSystemView view = FileSystemView.getFileSystemView();
                Icon smallIcon = view.getSystemIcon(file);
                ShellFolder shellFolder = ShellFolder.getShellFolder(file);
                Icon bigIcon = new ImageIcon(shellFolder.getIcon(true));
                setIconLabel(smallIcon, bigIcon);
                file.delete();
            }
            catch (IOException ioe)
            {
                ioe.printStackTrace();
            }
        }
    }

    private void setIconLabel(Icon smallIcon, Icon bigIcon)
    {
        smallIconLabel.setIcon(smallIcon);
        bigIconLabel.setIcon(bigIcon);
    }

    public static void main(String[] args)
    {
        FileIconExtractor fie = new FileIconExtractor();
    }
}
