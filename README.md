# **Scanni**

The Scanni app is to be used by students from LUCA School of Arts and the persons 
responsible for the workplaces in the school.

In the workplaces students can use different machines while working on their projects. 
Typical machines are sawing machines, milling machines, electrical screwdrivers, 3D printers, 
laser cutters,…Certain equipment can be used without instruction, but other, more specialized, 
equipment may only be used when some training has been followed successfully.

To prove that a student has the required knowledge to use a certain machine of 
equipment, he/she receives a certificate. These certificates will be provided digitally only. The 
app will allow to check that the student has the certificate.

# **Installation**:  

To Install Scanni you can download the repository, open it with an IDE such as android studio and start the main.dart file.  
To use the app, configure a emulated device or connect your Android phone to the pc. 

*Required Plugins*: 
- Flutter  
- Dart  

# Important Files and Folders  

**lib**:    Main folder which includes most of the app.    
**data**:   Includes most of the logic and data used in the pages.  
**helper**: Includes helping functions such as qr scanner and navbar.  
**pages**:  Includes all the pages used in shown when using the application.  

# Using the app

|**Login Screen** | Description |
| --------------- | ----------- |
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654393-51cbdf80-d14b-11eb-8e7f-c99a9261881b.png"> | This is a simple login screen. The user can log on with his R-Number and the Base64 code he will receive when selecting the "Register here" button. |  
| **Home Screen** |             |
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654357-fe599180-d14a-11eb-9b0f-ce10df15051e.png"> | On the Homescreen the user is instantly able to Scan a QR code or use the navbar on the bottom to direct to another page |
| **History**     |             |              
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654363-103b3480-d14b-11eb-8c05-3fb9fa1ba8b0.png"> | A view of Workplaces and Machines the user recently scanned  |
| **Workspaces**  |             |
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654364-1af5c980-d14b-11eb-97bc-a382280c2ee6.png"> | A list of all Workplaces with the option to see all Machines which are used in them |
| **Machines**    |             |
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654370-29dc7c00-d14b-11eb-93e6-7e92e8e43ae9.png"> | A listing of Machines which are avaliable in a specific Workplace. The User is also able to filter the list of machines which he/she has a granted Certificate for. Every Machine has safetyinstruction which the user can view by pressing "Safety Instructions" |
| **Sidebar**     |             |
| <img width ="320" heigth="640" align="left" src="https://user-images.githubusercontent.com/70316076/122654381-34971100-d14b-11eb-849f-dd5606f6200b.png"> | The Sidebar is accessible by pressing the icon on the top left. There you can see your username and r-number. Below are options for settings and a logout |



