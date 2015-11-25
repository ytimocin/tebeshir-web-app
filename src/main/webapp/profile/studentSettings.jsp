<%-- 
    Document   : studentSettings
    Created on : Jan 27, 2014, 1:52:50 PM
    Author     : yetkin.timocin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>student settings</title>
    </head>
    <body>
        <div class="tab-pane" id="tab_1_4">
            <div class="row">
                <div class="col-md-12">
                    <table id="user" class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <td style="width:15%">Username</td>
                                <td style="width:50%"><a href="#" id="username" data-type="text" data-pk="1" data-original-title="Enter username">superuser</a></td>
                                <td style="width:35%"><span class="text-muted">Simple text field</span></td>
                            </tr>
                            <tr>
                                <td>First name</td>
                                <td><a href="#" id="firstname" data-type="text" data-pk="1" data-placement="right" data-placeholder="Required" data-original-title="Enter your firstname"></a></td>
                                <td><span class="text-muted">Required text field, originally empty</span></td>
                            </tr>
                            <tr>
                                <td>Sex</td>
                                <td><a href="#" id="sex" data-type="select" data-pk="1" data-value="" data-original-title="Select sex"></a></td>
                                <td><span class="text-muted">Select, loaded from js array. Custom display</span></td>
                            </tr>
                            <tr>
                                <td>Group</td>
                                <td><a href="#" id="group" data-type="select" data-pk="1" data-value="5" data-source="/groups" data-original-title="Select group">Admin</a></td>
                                <td><span class="text-muted">Select, loaded from server. <strong>No buttons</strong> mode</span></td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td><a href="#" id="status" data-type="select" data-pk="1" data-value="0" data-source="/status" data-original-title="Select status">Active</a></td>
                                <td><span class="text-muted">Error when loading list items</span></td>
                            </tr>
                            <tr>
                                <td>Plan vacation?</td>
                                <td><a href="#" id="vacation" data-type="date" data-viewformat="dd.mm.yyyy" data-pk="1" data-placement="right" data-original-title="When you want vacation to start?">25.02.2013</a></td>
                                <td><span class="text-muted">Datepicker</span></td>
                            </tr>
                            <tr>
                                <td>Date of birth</td>
                                <td><a href="#" id="dob" data-type="combodate" data-value="1984-05-15" data-format="YYYY-MM-DD" data-viewformat="DD/MM/YYYY" data-template="D / MMM / YYYY" data-pk="1"  data-original-title="Select Date of birth"></a></td>
                                <td><span class="text-muted">Date field (combodate)</span></td>
                            </tr>
                            <tr>
                                <td>Setup event</td>
                                <td><a href="#" id="event" data-type="combodate" data-template="D MMM YYYY  HH:mm" data-format="YYYY-MM-DD HH:mm" data-viewformat="MMM D, YYYY, HH:mm" data-pk="1"  data-original-title="Setup event date and time"></a></td>
                                <td><span class="text-muted">Datetime field (combodate)</span></td>
                            </tr>
                            <tr>
                                <td>Meeting start</td>
                                <td><a href="#" id="meeting_start" data-type="datetime" data-pk="1" data-url="/post" data-placement="right" title="Set date & time">15/03/2013 12:45</a></td>
                                <td><span class="text-muted">Bootstrap datetime</span></td>
                            </tr>
                            <tr>
                                <td>Comments</td>
                                <td><a href="#" id="comments" data-type="textarea" data-pk="1" data-placeholder="Your comments here..." data-original-title="Enter comments">awesome<br>user!</a></td>
                                <td><span class="text-muted">Textarea. Buttons below. Submit by <i>ctrl+enter</i></span></td>
                            </tr>
                            <tr>
                                <td>Type State</td>
                                <td><a href="#" id="state" data-type="typeahead" data-pk="1" data-placement="right" data-original-title="Start typing State.."></a></td>
                                <td><span class="text-muted">Bootstrap typeahead</span></td>
                            </tr>
                            <tr>
                                <td>Fresh fruits</td>
                                <td><a href="#" id="fruits" data-type="checklist" data-value="2,3" data-original-title="Select fruits"></a></td>
                                <td><span class="text-muted">Checklist</span></td>
                            </tr>
                            <tr>
                                <td>Tags</td>
                                <td><a href="#" id="tags" data-type="select2" data-pk="1" data-original-title="Enter tags">html, javascript</a></td>
                                <td><span class="text-muted">Select2 (tags mode)</span></td>
                            </tr>
                            <tr>
                                <td>Country</td>
                                <td><a href="#" id="country" data-type="select2" data-pk="1" data-value="BS" data-original-title="Select country"></a></td>
                                <td><span class="text-muted">Select2 (dropdown mode)</span></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><a href="#" id="address" data-type="address" data-pk="1" data-original-title="Please, fill address"></a></td>
                                <td><span class="text-muted">Your custom input, several fields</span></td>
                            </tr>
                            <tr>
                                <td>Notes</td>
                                <td>
                                    <div id="note" data-pk="1" data-type="wysihtml5" data-toggle="manual" data-original-title="Enter notes">
                                        <h3>WYSIWYG</h3>
                                        WYSIWYG means <i>What You See Is What You Get</i>.<br>
                                        But may also refer to:
                                        <ul>
                                            <li>WYSIWYG (album), a 2000 album by Chumbawamba</li>
                                            <li>"Whatcha See is Whatcha Get", a 1971 song by The Dramatics</li>
                                            <li>WYSIWYG Film Festival, an annual Christian film festival</li>
                                        </ul>
                                        <i>Source:</i> <a href="http://en.wikipedia.org/wiki/WYSIWYG_(disambiguation)">wikipedia.org</a> 
                                    </div>
                                </td>
                                <td><a href="#" id="pencil"><i class="fa fa-pencil"></i> [edit]</a><br><span class="text-muted">Wysihtml5 (bootstrap only).<br>Toggle by another element</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
