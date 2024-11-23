# User Access Management System

A modern web-based system for managing user access to software applications within an organization. Built with Java, Jakarta EE 10, and Bootstrap 5.

## Features

- User Registration with Email Verification
- Secure Authentication System
- Software Application Management
- Access Request Workflow
- Role-based Access Control (RBAC)
- Request History Tracking
- Modern, Responsive UI
- Client-side Form Validation

## User Roles

1. Employee
   - Create and manage account
   - Request software access with multiple access levels
   - Track request status
   - View request history
   - Update profile information

2. Manager
   - All Employee privileges
   - Review pending access requests
   - Approve or reject requests with comments
   - View team's request history
   - Generate access reports

3. Admin
   - All Manager privileges
   - Create and manage software applications
   - Define access levels for software
   - Manage user roles and permissions
   - System configuration
   - Audit logging

## Technology Stack

### Backend
- Java 11
- Jakarta EE 10
- Apache Tomcat 10.1
- PostgreSQL 12+
- Maven 3.6+

### Frontend
- Bootstrap 5.1.3
- Bootstrap Icons 1.7.2
- HTML5/CSS3
- JavaScript (ES6+)
- JSP/JSTL 3.0

### Security
- BCrypt password hashing
- Role-based access control
- Session management
- CSRF protection
- XSS prevention
- Input validation
- SQL injection protection

## Prerequisites

- JDK 11 or higher
- Apache Tomcat 10.1.x
- PostgreSQL 12 or higher
- Maven 3.6 or higher
- Modern web browser (Chrome, Firefox, Edge)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Abhayaj247/user-access-management.git
   cd user-access-management
   ```

2. Configure PostgreSQL:
   - Create a database named 'uams'
   - Update credentials in `src/main/webapp/META-INF/context.xml`
   ```xml
   <Resource
      name="jdbc/uamsDB"
      auth="Container"
      type="javax.sql.DataSource"
      username="your_username"
      password="your_password"
      driverClassName="org.postgresql.Driver"
      url="jdbc:postgresql://localhost:5432/uams"
      maxTotal="20"
      maxIdle="10"
      maxWaitMillis="-1"/>
   ```

3. Initialize the database:
   ```bash
   psql -U postgres -d uams -f src/main/resources/db/init.sql
   ```

4. Set environment variables:
   ```bash
   set JAVA_HOME=path/to/java
   set CATALINA_HOME=path/to/tomcat
   ```

5. Build and deploy:
   ```bash
   mvn clean package
   copy target\uams.war %CATALINA_HOME%\webapps\
   ```

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── uams/
│   │           ├── servlet/    # Request handlers
│   │           ├── model/      # Data models
│   │           ├── dao/        # Data access objects
│   │           ├── filter/     # Security filters
│   │           └── util/       # Utility classes
│   ├── resources/
│   │   ├── db/                # Database scripts
│   │   └── log4j.properties   # Logging configuration
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── jsp/           # JSP views
│       │   ├── tags/          # Custom tag files
│       │   └── web.xml        # Web configuration
│       └── META-INF/
│           └── context.xml    # Tomcat configuration
```

## Database Schema

### Users Table
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Software Table
```sql
CREATE TABLE software (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    access_levels TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Requests Table
```sql
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    software_id INTEGER REFERENCES software(id),
    access_type VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    response_date TIMESTAMP,
    responder_id INTEGER REFERENCES users(id)
);
```

## Security Implementation

1. Authentication
   - BCrypt password hashing
   - Session-based authentication
   - Remember-me functionality
   - Password strength requirements

2. Authorization
   - Role-based access control
   - URL pattern security
   - Method-level security
   - Custom security filters

3. Data Protection
   - Prepared statements
   - Input validation
   - Output encoding
   - CSRF tokens
   - Secure headers

## UI Features

1. Modern Design
   - Clean, intuitive interface
   - Responsive layout
   - Bootstrap 5 components
   - Custom styling

2. Form Validation
   - Client-side validation
   - Server-side validation
   - Real-time feedback
   - Error highlighting

3. Navigation
   - Role-based menu items
   - Active state indicators
   - Breadcrumb navigation
   - Mobile-friendly menu

4. Notifications
   - Success/error messages
   - Status indicators
   - Loading states
   - Toast notifications

## Default Credentials

After installation, use these credentials:
- Admin:
  - Username: admin
  - Password: admin123


**Important:** Change these passwords immediately after first login.

## Troubleshooting

### Database Issues
1. Connection Failed
   - Verify PostgreSQL service is running
   - Check database credentials
   - Confirm database exists
   - Test connection with psql

### Deployment Issues
1. Compilation Errors
   - Verify Java version
   - Update Maven dependencies
   - Clear Maven cache

2. Runtime Errors
   - Check Tomcat logs
   - Verify JNDI resources
   - Confirm file permissions

### UI Issues
1. Style Problems
   - Clear browser cache
   - Check console for errors
   - Verify Bootstrap loading
   - Test in different browsers

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow coding standards
4. Write unit tests
5. Submit pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
