# Online-Photo-Social-Network-System

The following interaction with the system is implemented:

User management

1. Becoming a registered user. Before being able to upload photos a user can register by providing their first name, last name, email address, date of birth, and a password.

2. Adding and Listing Friends. User can add a new friend on the friend list. Also, user can search for other users in the system (in order to find friends to add.) Finally, user can list his/her friends.

3. User activity. To motivate users in using the site, the ones who make the largest contribution and list them on the site can be verified. The contribution of a user is based on the number of photos they have uploaded plus the number of comments they have left for photos belonging to other users. The top 10 users are reported.

Album and photo management

1. Photo and album browsing. Every visitor to the site, registered or not, is allowed to browse photos. 

2. Photo and album creating. After registration, users can start creating albums and uploading photos. Users can delete both albums and photos. If an non-empty album is deleted its photos should also be purged. Users can modify and delete albums and photos which they own.

Tag management

1. Viewing your photos by tag name. Tags provide a way to categorize photos and each photo can have any number of tags. You may think of them as virtual albums. For example, suppose that a user has two distinct albums each of which contains a photo with the tag 'friends'. The means should be provided to view the virtual album created if we select all the photos owned by the user that contain the tag 'friends'. One possible user interface design for this functionality is to present tags as hyperlinks. When a tag is clicked the photos tagged with it are listed.

2. Viewing all photos by tag name. Furthermore, the system should allow users to view all photos that contain a certain tag, i.e., not only the ones they have uploaded but also photos that belong to other users. This functionality is similar to the one above and hence they could be presented together. One possible representation is a switch of the form "View all photos / View my photos" that when toggled switches from one view to the other.

3. Viewing the most popular tags. A function should be provided that lists the most popular tags, i.e., the tags that are associated with the most photos. Again, tags should be clickable so that when a user clicks one of them all photos tagged with this tag are listed.

4. Photo search. The functionality should be provided so that both visitors and registered users can search through the photos by specifying conjunctive tag queries. For example a visitor could enter the words "friends boston" in a text field, click the search button and be presented with all photos that contain both the tag "friends" and the tag "boston".

Comments

1. Leaving comments. Both registered and anonymous users can leave comments. Users cannot leave comments for their own photos. If registered user leaves a comment then this counts towards their contribution score as described above.

2. Like functionality. If a user likes a photo, should be able to add a like to the photo. Also, we must be able to see how many likes a photo has and the users that liked this photo.

Recommendations

1. 'You-may-also-like' functionality. Given the type of photos uploaded by a user we'd like to make some recommendations to them about other photos they may like. To achieve that do the following: Take the five most commonly used tags among the user's photos. Perform a disjunctive search through all the photos for these five tags. A photo that contains all five tags should be ranked higher than one that contained four of the tags and so on. Between two photos that contain the same number of matched tags prefer the one that is more concise, i.e., the one that has fewer tags over all.

2. Tag recommendation functionality. We want to assist users in selecting tags for their photos. To do that ask the user to enter a couple of tags that they already have in mind. Perform a query and find all the photos, belonging to any user, that contain these tags. Take the tags of these photos in the result set and order them by frequency of occurrence (obviously you have to exclude the tags that were part of the query). Report back the most frequent tags as recommendations.
