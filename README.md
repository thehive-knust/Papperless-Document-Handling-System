# Papperless-Document-Handling-System

This is a collaborative project work for the Software Engineering Course 2021.
The goal of this project is to develop and design an effective software solution for
handling documents processing in the College of Engineering, KNUST. Specifically,
internal document approvals.

# Contributors - Name (Index No. - Role)

Ayarma Emmanuel John (3581418 - Quality Assurance Officer)
OCUPUALOR ELIJAH (3591218 - Project Manager)
Saeed Abdul-Mateen Demah (3587518 - System Analyst)
Alidu abukari baba(3590218)
Sackey Emmanuel James Ato Sackey (3587418 - Head of Frontend)
Andrews Tang (3587618 - Head of Backend)
Obed Ansah (3579718)-Member. Osei-Bonsu Alexander Kwasi Tweneboah- ( Head of Multimedia)


# Server APIs
**User APIs**\
Login : /user/login\
Sign-Up : /user/register/{user_id}\
Delete User : /user/delete/{user_id}\
Get User by mail    : /user/{email}\
Get User by ID  : /user/{user_id}\
Get All Users : /user/all

**Document APIs**\
Upload document : /document/upload\
Get new documents : /document/new/{user_id}\
Get approved docs : /document/approved/{user_id}\
Get rejected docs : /document/rejected/{user_id}
