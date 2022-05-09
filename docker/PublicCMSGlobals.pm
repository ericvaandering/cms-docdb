#
# Description: Configuration file for your projects DocDB settings.
#      Author: Eric Vaandering (ewv@fnal.gov)
#    Modified:

# Copyright 2001-2009 Eric Vaandering, Lynn Garren, Adam Bryant

#    This file is part of DocDB.

#    DocDB is free software; you can redistribute it and/or modify
#    it under the terms of version 2 of the GNU General Public License
#    as published by the Free Software Foundation.

#    DocDB is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with DocDB; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

# DB settings
$Public  = 1;
$Preferences{Components}{iCal}  = $FALSE; # Display links to iCal calendars

# Name and e-mail address of the administrators (or mailing list for admins)

$DBWebMasterEmail = "cms-docdb-admin\@cern.ch";
$DBWebMasterName  = "CMS DocDB Administrators";

$AuthUserFile     = "/afs/cern.ch/user/e/ewv/.htpasswd";
$MailServer       = "localhost";

# Text customization. Leave $WelcomeMessage blank for no message on top of DB
# BTeV uses a welcome message for the public part of the DB, but not for the
# private

$FirstYear      = 1990;           # Earliest year that documents can be created
$Project        = "CMS";
$ShortProject   = "CMS";    # This is the project used in the Document ID

# ----- No other changes are needed for the DocDB. However, there are
# ----- other configuration settings you may want to investgate

# ----- At this point you can also change any of the other variables in
# ----- DocDBGlobals.pm for things like $HomeLastDays, command locations
# ----- (if not using Linux) etc.

#$LastDays             = 20;    # Number of days for default in LastModified
#$HomeLastDays         = 7;     # Number of days for last modified on home page
#$HomeMaxDocs          = 50;    # Maximum number of documents on home page
#$MeetingWindow        = 7;     # Days before and after meeting to preselect
#$TalkHintWindow       = 7;     # Days before and after to guess on documents
#$MeetingFiles         = 3;     # Number of upload boxes on meeting short form
#$InitialSessions      = 5;     # Number of initial sessions when making meeting

# Which things are publicly viewable?

$PublicAccess{MeetingList} = 0;

# ----- These are some options for extra features of the DocDB that can be
# ----- enabled. Values shown are defaults, change 0 -> 1 to enable a feature.
# ----- There are a lot of other options shown in DocDBGlobals.pm. You can
# ----- change any of them here.

$CaseInsensitiveUsers = 1;     # Can use "Project" for a name in the
                               # security groups, but "project" in .htaccess

$UserValidation = "shibboleth";          # || "basic" || "certificate"
                                # Do we do group authorization like V5 and before
                                # or do we allow .htaccess/.htpasswd users to map to groups (basic)
                                # or require SSL certificates of users which map to groups (certificate)
#$ReadOnly       = 0;           # Can be used in conjunction with individual
                                # authorization methods to set up a group-like
                                # area with group passwords which can view
                                # but not change any info

$UseSignoffs          = 1;     # Sign-off system for document approval
$MailInstalled        = 1;     # Is the Mailer::Mail module installed?

#$ContentSearch        = "cd /path/to/search/script; ./ContentSearch";
                         # Scripts and engine installed for searching files


1;
