#
# Description: These are routines that are specific to your installation and
#              should be customized for your needs. This file is a template
#              only. Make a copy of this file as ProjectRoutines.pm (no
# "template") and make your changes there. Basically you can use ProjectHeader,
# ProjectBodyStart, ProjectFooter, and DocDBFooter to make DocDB  web pages
# just like the web pages for the rest of your project. If you don't want to do
# any customization or just want to test DocDB, these routines work as-is.
# A global variable $Public is used (when set) to remove elements from the
# nav-bars that the public has no interest in. The variable is global
# and can control the style of your headers and footers too.
#
#      Author: Eric Vaandering (ewv@fnal.gov)
#    Modified:

# Copyright 2001-2004 Eric Vaandering, Lynn Garren, Adam Bryant
# Copyright 2010 Vidmantas Zemleris

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
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

sub ProjectHeader {
 my ($Title,$PageTitle,%Params) = @_;
 my @Scripts = @{$Params{-scripts}};
 my @JQueryElements = @{$Params{-jqueryelements}};


#  my ($Title,$PageTitle) = @_;


# This routine is reponsible for whatever HTML you want to write in the <HEAD>
# section of the page. You can embed style sheets, etc.
#
# $Title is what is in the <title> element while $PageTitle is the title  of
# the page you may put in the text of the page. They are provided here for
# your  convenience, but you should not print the <title> here since DocDB
# already takes  care of that.

 # Figure out if jquery has been already loaded

# print "JQelements: @JQueryElements";
# print "Scripts: @Scripts";

 # Checking if the compelate path is included would fail, in the case jquery version has been updated
 # other option if to see if there is jquery in the filename of any scripts and assume that that implies that jquery is loaded too.
 # "jquery-autocomplete/jquery-1.4.2.min"

 @jqueryScripts = grep(/jquery-[^\/]+$/, @Scripts);

# print  "jqueryScripts: @jqueryScripts";
 if (not @jqueryScripts){
     # load jquery if it wasn't loaded
     print "<script type=\"text/javascript\" src=\"$JSURLPath/jquery-autocomplete/jquery-1.4.2.min.js\"></script>";
 }


   # TODO: Temp link to CSS (cross-site!!)
 my $str = <<EOF;
    <script type="text/javascript" src="$JSURLPath/CMS-jquery.watermark.min.js"></script>
        <script type="text/javascript" src="$JSURLPath/CMS-curvycorners.js"></script>


    <script type="text/javascript">
            var isInIFrame = (window.location != window.parent.location) ? true : false;
            if (isInIFrame){
                    document.write(unescape("%3Cstyle type='text/css' %3E #header-logo, #header-search-container, #title-div, #header-main  {display: none!important; visibility: hidden!important; } #cms-content-container { background: none; } #cms-content-container-inner { border: none; }  %3C/style%3E"));

                    // only if it's in iframe  I load the resizing script

                        var IFRAME_SCRIPT_URL = 'test-zemleris.web.cern.ch/test-zemleris/fix-iframe/resize-iframe-provider.js';

                        var gaJsHost = (("https:" == document.location.protocol) ? "https://" : "http://");
                        var src = gaJsHost + IFRAME_SCRIPT_URL;
                        document.write(unescape("%3Cscript src='" + src + "' type='text/javascript'%3E%3C/script%3E"));
            }
    </script>


    <!--[if IE]>
        <link rel="stylesheet" href="$CSSURLPath/CMSDocDB_IE.css" type="text/css" />
    <![endif]-->


    <script type="text/javascript">

      var docDB_temp_hacks = 0;


          function extended_author_search(){
            jQuery.extend(jQuery.expr[':'], {
              'containsi': function(elem, i, match, array)
              {
                return (elem.textContent || elem.innerText || '').toLowerCase()
                .indexOf((match[3] || "").toLowerCase()) >= 0;
              }
            });
            jQuery.extend({URLEncode:function(c){var o='';var x=0;c=c.toString();var r=/(^[a-zA-Z0-9_.]*)/;
              while(x<c.length){var m=r.exec(c.substr(x));
                if(m!=null && m.length>1 && m[1]!=''){o+=m[1];x+=m[1].length;
                }else{if(c[x]==' ')o+='+';else{var d=c.charCodeAt(x);var h=d.toString(16);
                o+='%'+(h.length<2?'0':'')+h.toUpperCase();}x++;}}return o;},
            URLDecode:function(s){var o=s;var binVal,t;var r=/(%[^%]{2})/;
              while((m=r.exec(o))!=null && m.length>1 && m[1]!=''){b=parseInt(m[1].substr(1),16);
              t=String.fromCharCode(b);o=o.replace(m[1],t);}return o;}
            });


            // extract url parameter
            jQuery.extend({
              getUrlVars: function(){
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for(var i = 0; i < hashes.length; i++)
                {
                  hash = hashes[i].split('=');
                  vars.push(hash[0]);
                  vars[hash[0]] = hash[1];
                }
                return vars;
              },
              getUrlVar: function(name){
                return jQuery.getUrlVars()[name];
              }
            });

            var author_search = jQuery.getUrlVar('author');


            if (author_search){
                jQuery('h3').html(jQuery('<a href="#">show all authors</a>').click(function(){jQuery('table tr td ul li, table tr td a, table tr th').show(); })).show();


                jQuery('table tr td ul li, table tr td a, table tr th').hide();

                params = author_search.replace('.', ' ').replace('+', ' ').replace(',', ' ').split(' ')

                filtered = jQuery('table tr td ul li a')

                jQuery(params).each(function(i, param){
                    //TODO: handle special chars and international names
                    //console.log(param);

                        //clean up the string, leave only letters
                        param = param.replace(/[^a-zA-Z]/g, '');
                        if (!param)
                                return;

                    filtered = filtered.filter(':containsi('+param+')');
                });
                items = filtered.show().parent().show().addClass('search_matched')


                //console.log(items)

                /* If there was only one result, point to the documents by the author */
                if (items.length == 1){
                            var target = items.find("a").first().attr('href');
                        //console.log("Blah:"+target);
                        location.href = target;
                }
            }

          }


      function apply_cms_styles(){
            /* watermark the search */
                        var searchField = jQuery('div#header-search-container input[type=text][name=simpletext]');
                        /* we take the value of watermark from title attribute */
            searchField.watermark(searchField.attr('title'),  {className: 'watermark-search'});

            jQuery('div#header-search-container form').submit(function(e){
                //check if value has an ID
                var value =jQuery('input#header-search-input').val();
                //alert(value);
                var regexp = /id:(\\d+)/i;
                if (regexp.test(value)){
                    //alert('ID');
                    e.preventDefault();
                    value.match(regexp);
                    docid = RegExp.\$1;
                    window.location.href = 'ShowDocument?docid=' + docid
                }
            });


                /* hide keywords */
                if (jQuery('form#documentadd input[name=keywords]')) {
                    jQuery('form#documentadd input[name=keywords]').parents("tr").first().hide();
                }



            if (docDB_temp_hacks){
                /* TODO: (temporaly) set up file input coloring */
                for (i=1; i<1000; i=i+2){
                    if (!jQuery('input[name=upload'+i+']'))
                       break;
                   jQuery('input[name=upload'+i+']').parents('tr').first().addClass('file-upload-row-odd');
                   jQuery('input[name=filedesc'+i+']').parents('tr').first().addClass('file-upload-row-odd');
                   jQuery('input[name=fileid'+i+']').parents('tr').first().addClass('file-upload-row-odd');
                }

                /* add select all button */
                if (jQuery('form#documentadd input[name=copyfile1]')){
                    jQuery('form#documentadd input[name=copyfile1]').parents("td").first().append('   <a>copy all files<a>').toggle(function(evt){evt.preventDefault();jQuery('[name^="copyfile"]').val(["on"])}, function(evt){evt.preventDefault();jQuery('[name^="copyfile"]').val([""])})
                }

           }


      }

                /*  ==========  set up the validation  =========== */
          function form_add_validation(){

                jQuery.validator.messages.required = "";

                /* pre-validate the form */
                jQuery("form#documentadd").validate({onfocusout: true, onkeyup: true});
          }

    function add_login_link(){
        var login_lnk = jQuery('<a id="login-link">Login</a>');

        /* just remove the public to get private docdb location */
        var private_docdb = document.location.href.replace('/PublicDocDB/', '/DocDB/').replace('/PublicEPPOGDocDB/', '/EPPOGDocDB/');

        login_lnk.attr('href', private_docdb);
        jQuery('#cms_my_account').append(login_lnk);
    }

          if (!(typeof jQuery === 'undefined') && !(typeof jQuery.validator === 'undefined')){
          jQuery(document).ready(function() {
                /* Here we could customize the validation (again) */
                                form_add_validation();
          });
          }

          if (!(typeof jQuery === 'undefined')){
          jQuery(document).ready(function() {
                apply_cms_styles();
                                extended_author_search();
                add_login_link();
          });
      }
    </script>
EOF

 print $str;


}


sub ProjectBodyStart {
  # This routine is called after the <body> tag is written. Here you can put your
  # project specific HTML. You might want to put the document title too, as a
  # header. ($Title is what is in the <title> element while $PageTitle is the
  # title  of the page you may put in the text of the page.)

  my ($Title,$PageTitle) = @_;
  my @TitleParts = split /\s+/, $PageTitle;
  $PageTitle = join '&nbsp;',@TitleParts;

  my $SearchDiv  = $query -> startform('POST',$Search);
     $SearchDiv .=      $query -> textfield(-name => "simpletext", -size => 40, -maxlength => 300, -id=>'header-search-input', -title=>'Search by title, author, topic or by id:DocID', -override => '');
     $SearchDiv .=      "&nbsp;";
     $SearchDiv .=      $query -> submit (-value => "Search");
     $SearchDiv .=      $query -> hidden(-name => "simple", -override => '1');
     $SearchDiv .=      "&nbsp;<a href=\"$SearchForm#Advanced\">Advanced search</a>";
     $SearchDiv .= $query -> endform();


  require "Security.pm";
  my $extraLinks = "";


  # Add menu items according to permissions
  $OptMenuItems = "";


  if (&CanAdminister()) {
    $extraLinks .= "<a href=\"$AdministerHome\">Admin area</a>&nbsp;\n";
  }



  unless ($Public) {
                if (&CanCreate()) {
                $OptMenuItems .= "<li><a href=\"$DocumentAddForm?mode=add;quick=1\" class=\"rounded\">Submit document</a></li>";
                $OptMenuItems .="<li><a href=\"$ModifyHome\" class=\"rounded\">Modify document</a></li>";
                }

            $OptMenuItems .= "<li><a href=\"$DocDBInstructions\" class=\"rounded\">Help</a></li>";

                # Add these links only for non public
                $extraLinks .= "<a href=\"$SelectPrefs\">My preferences</a>&nbsp;
                                                                <a href=\"$SelectEmailPrefs\">Email notifications</a>
                                            <a href=\"$SelectGroups\" class=\"rounded\" target=\"_blank\">Limit my groups</a>";
   }



  my $str = <<EOF;
        <div id="cms-content-container" align="center">
                <div id="cms-content-container-inner" align="left">

                        <div id="header-main">

                                 <div id="header-logo">
                                         <a href="$MainPage">
                                                <div id="cms-logo">
                                                </div>

                                        </a>
                                 </div>


                                 <div id='header-search-container'>
                                          $SearchDiv

                                          <div id="search-browse"><b>Browse by</b>:

                                                <a href="$ListAuthors">author</a>,&nbsp;
                                                <a href="$ListTopics">topic</a>, &nbsp;
                                                <!-- <a href="$ListGroups">group</a>, &nbsp; -->
                                                <!-- <a href="$ListAllMeetings">event</a>, &nbsp;-->
                                                <a href="$ListBy?days=$LastDays">see recent</a>, &nbsp;
                                                <a href="$ListBy?alldocs=1">see all</a> </div>
                                  </div>

                                  <div id="cms-menu">
                    <ul id="menu">

                                                <li  >
                                                        <a href="$MainPage" class="rounded"  class="activated" >Browse topics</a>
                                                </li>
                                                $OptMenuItems

                                        </ul>

                                        <div style="clear: both"></div>

                                  </div>
                        </div> <!-- end: header-main -->

                       <div style="clear: both"></div>

    <div id="cms_my_account">
                                                                                        $extraLinks

                        </div>


                       <div id="cms-main-content">

                         <h2>$PageTitle</h2>

                        <!-- not yet closed divs id: cms-content-container, cms-content-container-inner, cms-main-content -->
EOF

  print $str;

  # show the navbar at the top of the page as well as at the bottom
  #if ($dbh) {
  #   &DocDBNavBar();
  #}
}

sub ProjectBodyStart_old {

# This routine is called after the <body> tag is written. Here you can put your
# project specific HTML. You might want to put the document title too, as a
# header. ($Title is what is in the <title> element while $PageTitle is the
# title  of the page you may put in the text of the page.)

  my ($Title,$PageTitle) = @_;
  my @TitleParts = split /\s+/, $PageTitle;
  $PageTitle = join '&nbsp;',@TitleParts;

  print "<table id=\"CMSHeaderTable\"><tr>\n";
  print '<td><img src="https://cms-docdb.cern.ch/DocDB/Static/Public/CMS-Color-100.gif" width=100></td>';
  print "<td><h1>$PageTitle</h1></td>\n";
#  print "<td><img src=\"http://docdb.fnal.gov/CMS/DocDB/Static/Public/CMS-Color-100.gif\" width=100></td>\n";
  print "</tr></table>\n";
  DocDBNavBar();
}

sub ProjectFooter {
  require "DocDBVersion.pm";

  my ($WebMasterEmail,$WebMasterName) = @_;

  # This routine is reponsible for whatever you want to put as a footer on the
  # page.
  #
  # Parameters are supplied for the name and e-mail address of the person
  # responsible for the pages. We would appreciate it if you keep the link to
  # the DocDB home page present.

  # You probably want to include some version of this:



  print "</div><!-- end of cms-main-content --> <div id='cms-footer'><p><small>\n";

    print "<div style='float: right'>Contact \n";
  print "<i>\n";
  print "<a href=\"mailto:$WebMasterEmail\">$WebMasterName</a>\n";
  print "</i>\n";
  print "</small></div>";


  print "<a href=\"$DocDBHome\">DocDB</a> ";
  print "Version $DocDBVersion,  <a href=\"$Statistics\"> database statistics</a>.";

  print "</div>\n";

  # This prints benchmark info for pages that have it

  if ($EndTime && $StartTime) {
    my $TimeDiff = timediff($EndTime,$StartTime);
    print "<small><b>Execution time: </b>",timestr($TimeDiff),"</small>\n";
  }
  print "</p>\n";

  # close the main formating containers
  print '    </div>     <!-- id="cms-content-container -->';
  print '</div>         <!-- id="cms-content-container-inner -->';

  # Do not print the </body> and </html> tags, DocDB does that now.
}

sub DocDBNavBar {

# This routine prints the navigation bar just above the footer on the
# page.
# This provides a good default, but you can customize for your installation
# and include an optional extra description and URL (e.g. for a related page).


  my ($ExtraDesc,$ExtraURL) = @_;

  require "Security.pm";
  return;

  print "<div align=\"center\">\n";
  if ($ExtraDesc && $ExtraURL) {
    print "[&nbsp;<a href=\"$ExtraURL\"l>$ExtraDesc</a>&nbsp;]&nbsp;\n";
  }
  print "[&nbsp;<a href=\"$MainPage\">DocDB&nbsp;Home</a>&nbsp;]&nbsp;\n";
  if (&CanAdminister()) {
    print "[&nbsp;<a href=\"$AdministerHome\">Administer</a>&nbsp;]&nbsp;\n";
  }
  if (&CanCreate()) {
    print "[&nbsp;<a href=\"$DocumentAddForm?mode=add\">New</a>&nbsp;]&nbsp;\n";
  }
  print "[&nbsp;<a href=\"$SearchForm\">Search</a>&nbsp;]\n";
  print "[&nbsp;<a href=\"$ListBy?days=$LastDays\">Last&nbsp;$LastDays&nbsp;Days</a>&nbsp;]\n";
  print "[&nbsp;<a href=\"$ListAuthors\">List&nbsp;Authors</a>&nbsp;]\n";
  print "[&nbsp;<a href=\"$ListTopics\">List&nbsp;Topics</a>&nbsp;]\n";
  unless ($Public) {
    print "[&nbsp;<a href=\"$DocDBInstructions\">Help</a>&nbsp;]\n";
#    print "[&nbsp;<a href=\"logout/LogOut\">Log Out</a>&nbsp;]\n";
  }
  print "</div>\n";
}

sub ProjectReferenceLink (;$$$$) {
  my ($Acronym,$Volume,$Page,$ReferenceID) = @_;

# This routine is used to add links to and optionally replace the text of
# references specific to the project.
# See ReferenceLink in ReferenceLinks.pm for examples.

  my $ReferenceLink = "";
  my $ReferenceText = "";

  return ($ReferenceLink,$ReferenceText);
}

# Often times groups may have CSS or other files that are used in Server
# Side Includes. This function replicates that functionality

#sub SSInclude {
#  my ($file) = @_;
#  open SSI,"$SSIDirectory$file";
#  my @SSI_lines = <SSI>;
#  close SSI;
#  print @SSI_lines;
#}

1;