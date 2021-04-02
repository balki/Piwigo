

{combine_script id='common' load='header' require='jquery' path='admin/themes/default/js/common.js'}

{combine_script id='jquery.selectize' load='header' path='themes/default/js/plugins/selectize.min.js'}
{combine_css id='jquery.selectize' path="themes/default/js/plugins/selectize.{$themeconf.colorscheme}.css"}

{combine_script id='jquery.ui.slider' require='jquery.ui' load='header' path='themes/default/js/ui/minified/jquery.ui.slider.min.js'}
{combine_css path="themes/default/js/ui/theme/jquery.ui.slider.css"}

{combine_script id='jquery.confirm' load='header' require='jquery' path='themes/default/js/plugins/jquery-confirm.min.js'}
{combine_css path="themes/default/js/plugins/jquery-confirm.min.css"}

{combine_script id='jquery.tipTip' load='header' path='themes/default/js/plugins/jquery.tipTip.minified.js'}

{footer_script}

/* Translates */
const title_msg = '{'Are you sure you want to delete the user "%s"?'|@translate|escape:'javascript'}';
const are_you_sure_msg  = '{'Are you sure?'|@translate|@escape:'javascript'}';
const confirm_msg = '{'Yes, I am sure'|@translate|@escape}';
const cancel_msg = '{'No, I have changed my mind'|@translate|@escape}';
const str_and_others_tags = '{'and %s others'|@translate}';
const missingConfirm = "{'You need to confirm deletion'|translate|escape:javascript}";
const missingUsername = "{'Please, enter a login'|translate|escape:javascript}";

const registered_str = '{"Registered"|@translate}';
const last_visit_str = '{"Last visit"|@translate}';
const dates_infos = '{'between %s and %s'|translate}'
const hide_str = '{'Hide'|@translate}';
const show_str = '{'Show'|@translate}';
const user_added_str = '{'User %s added'|@translate}';

months = [
  "{'Jan'|@translate}",
  "{'Feb'|@translate}",
  "{'Mar'|@translate}",
  "{'Apr'|@translate}",
  "{'May'|@translate}",
  "{'Jun'|@translate}",
  "{'Jul'|@translate}",
  "{'Aug'|@translate}",
  "{'Sep'|@translate}",
  "{'Oct'|@translate}",
  "{'Nov'|@translate}",
  "{'Dec'|@translate}"
];

/* Template variables */
connected_user = {$connected_user};
let groups_arr_name = [{$groups_arr_name}];
let groups_arr_id = [{$groups_arr_id}];
groups_arr = groups_arr_id.map((elem, index) => [elem, groups_arr_name[index]]);
guest_id = {$guest_id};
nb_days = "{'%d days'|@translate}";
//per page is too long for the popin
nb_photos = "{'%d photos'|@translate}";
nb_photos_per_page = "{'%d photos per page'|@translate}";
pwg_token = '{$PWG_TOKEN}';

let register_dates_str = '{$register_dates}';
let register_dates = register_dates_str.split(',');
{literal}
let groupOptions = groups_arr.map(x => ({value: x[0], label: x[1], isSelected: 0}));
{/literal}

/* Startup */
setupRegisterDates(register_dates);
selectionMode(false);
get_guest_info();
update_user_list();
update_selection_content();

{/footer_script}

{combine_script id='user_list' load='footer' path='admin/themes/default/js/user_list.js'}

{combine_script id='jquery.cookie' path='admin/themes/default/js/jquery.cookie.js' load='footer'}

<div class="selection-mode-group-manager" style="right:30px">
  <label class="switch">
    <input type="checkbox" id="toggleSelectionMode">
    <span class="slider round"></span>
  </label>
  <p>{'Selection mode'|@translate}</p>
</div>


<div id="user-table">
  <div id="user-table-content">
    <div class="user-manager-header">

      <div class="UserViewSelector">
        <input type="radio" name="layout" class="switchLayout" id="displayCompact" {if $smarty.cookies.pwg_user_manager_view == 'compact'}checked{/if}/><label for="displayCompact"><span class="icon-th-large firstIcon tiptip" title="{'Compact View'|translate}"></span></label><input type="radio" name="layout" class="switchLayout tiptip" id="displayLine" {if $smarty.cookies.pwg_user_manager_view == 'line' || !$smarty.cookies.pwg_user_manager_view}checked{/if}/><label for="displayLine"><span class="icon-th-list tiptip" title="{'Line View'|translate}"></span></label><input type="radio" name="layout" class="switchLayout" id="displayTile" {if $smarty.cookies.pwg_user_manager_view == 'tile'}checked{/if}/><label for="displayTile"><span class="icon-pause lastIcon tiptip" title="{'Tile View'|translate}"></span></label>
      </div>

      <div style="display:flex;justify-content:space-between; flex-grow:1;">
        <div style="display:flex; align-items: center;">
          <div class="not-in-selection-mode user-header-button add-user-button" style="margin: auto; margin-right: 10px">
            <label class="user-header-button-label icon-plus-circled">
              <p>{'Add a user'|@translate}</p>
            </label>
          </div>

          <div class="not-in-selection-mode user-header-button" style="margin: auto; margin-right: 10px">
            <label class="user-header-button-label icon-user-1 edit-guest-user-button">
              <p>{'Edit guest user'|@translate}</p>
            </label>
          </div>
          <div id="AddUserSuccess">
            <label class="icon-ok">
              <span>{'New user added'|@translate}</span><span class="icon-pencil edit-now">{'Edit'|@translate}</span>
            </label>
          </div>
          <div class="in-selection-mode">
            <div id="checkActions">
              <span>{'Select'|@translate}</span>
              <a href="#" id="selectAllPage">{'The whole page'|@translate}</a>
              <a href="#" id="selectSet">{'The whole set'|@translate}</a><span class="loading" style="display:none"><img src="themes/default/images/ajax-loader-small.gif"></span>
              <a href="#" id="selectNone">{'None'|@translate}</a>
              <a href="#" id="selectInvert">{'Invert'|@translate}</a>
              <span id="selectedMessage"></span>
            </div>
          </div>
        </div>
        <div style="display:flex; width: 270px;">
          {* <div id="advanced_filter_button">
            <span>{'Advanced filter'|@translate}</span>
          </div> *}
          {* <div id='search-user'>
            <div class='search-info'> </div>
            <span class='icon-filter search-icon'> </span>
            <span class="icon-cancel search-cancel"></span>
            <input id="user_search" class='search-input' type='text' placeholder='{'Filter'|@translate}'>
          </div> *}
        </div>
      </div>
      <div class="not-in-selection-mode" style="width: 264px; height:2px">
      </div>
    </div>
    <div id="advanced_filter_button">
      <span>{'Advanced filter'|@translate}</span>
    </div>
    <div id='search-user'>
        <div class='search-info'> </div>
          <span class='icon-filter search-icon'> </span>
          <span class="icon-cancel search-cancel"></span>
          <input id="user_search" class='search-input' type='text' placeholder='{'Filter'|@translate}'>
        </div>
    <div id="advanced-filter-container">
      <div class="advanced-filters-header">
        <span class="advanced-filter-title">{'Advanced filter'|@translate}</span>
        <span class="advanced-filter-close icon-cancel"></span>
      </div>
      <div class="advanced-filters">
        <div class="advanced-filter-status">
          <label class="advanced-filter-label">{'Status'|@translate}</label>
          <div class="advanced-filter-select-container">
            <select class="user-action-select advanced-filter-select" name="filter_status">
              <option value="" label="" selected></option>
              {html_options options=$pref_status_options}
            </select>
          </div>
        </div>
        <div class="advanced-filter-group">
          <label class="advanced-filter-label">{'Group'|@translate}</label>
          <div class="advanced-filter-select-container">
            <select class="user-action-select advanced-filter-select" name="filter_group">
              <option value="" label="" selected></option>
              {html_options options=$association_options}
            </select>
          </div>
        </div>
        <div class="advanced-filter-level">
          <label class="advanced-filter-label">{'Privacy level'|@translate}</label>
          <div class="advanced-filter-select-container">
            <select class="user-action-select advanced-filter-select" name="filter_level" size="1">
              <option value="" label="" selected></option>
              {html_options options=$level_options}
            </select>
          </div>
        </div>
        <div class="advanced-filter-date">
          <div class="advanced-filter-date-title" style="display:flex">
            <span class="advanced-filter-label">{'Registered'|@translate}</span>
            <span class='dates-infos'></span>
          </div>
          <div class="dates-select-bar">
              <div class="select-bar-wrapper">
                <div class="select-bar-container"></div>
              </div>
            </div>
        </div>
      </div>
    </div>
    <div class="user-container-header">
      <!-- edit / select -->
      <div class="user-header-col user-header-select no-flex-grow">
      </div>
      <!-- icon -->
      <div class="user-header-col user-header-initials no-flex-grow">
      </div>
      <!-- username -->
      <div class="user-header-col user-header-username">
        <span>{'Username'|@translate}</span>
      </div>
      <!-- status -->
      <div class="user-header-col user-header-status">
        <span>{'Status'|@translate}</span>
      </div>
      <!-- email adress -->
      <div class="user-header-col user-header-email not-in-selection-mode">
        <span>{'Email Adress'|@translate}</span>
      </div>
      {* <!-- groups -->
      <div class="user-header-col user-header-groups">
        <span>{'Groups'|@translate}</span>
      </div> *}
      <!-- registration date -->
      <div class="user-header-col user-header-registration">
        <span>{'Registered'|@translate}</span>
      </div>
       <!-- groups -->
       <div class="user-header-col user-header-groups">
       <span>{'Groups'|@translate}</span>
     </div>
    </div>
    <div class="user-update-spinner" style="position:relative">
      <img class="loading" src="themes/default/images/ajax-loader-small.gif" style="position:absolute;top:20px;width:30px">
    </div>
    <div class="user-container-wrapper">
    </div>
    <!-- Pagination -->
    <div class="user-pagination">
      <div class="pagination-per-page">
        <span class="thumbnailsActionsShow" style="font-weight: bold;">{'Display'|@translate}</span>
        <a id="pagination-per-page-5">5</a>
        <a id="pagination-per-page-10">10</a>
        <a id="pagination-per-page-25">25</a>
        <a id="pagination-per-page-50">50</a>
      </div>

      <div class="pagination-container">

        <div class="user-update-spinner">
          <img class="loading" src="themes/default/images/ajax-loader-small.gif">
        </div>
        <div class="pagination-arrow left">
          <span class="icon-left-open"></span>
        </div>
        <div class="pagination-item-container">
        </div>
        <div class="pagination-arrow rigth">
          <span class="icon-left-open"></span>
        </div>
      </div>
    </div>
  </div>
  <div id="selection-mode-block" class="in-selection-mode tag-selection" style="width: 250px; min-width:250px;display: block;position:relative">
    <div class="user-selection-content">
      <div class="selection-mode-ul">
        <p>{'Your selection'|@translate}</p>
        <div class="user-selected-list">
        </div>
        <div class="selection-other-users"></div>
      </div>
      <fieldset id="action">
        <legend>{'Action'|@translate}</legend>

        <div id="forbidAction">{'No users selected, no actions possible.'|@translate}</div>
        <div id="permitActionUserList" style="display:block">

          <div class="user-action-select-container">
            <select class="user-action-select" name="selectAction">
              <option value="-1">{'Choose an action'|@translate}</option>
              <optgroup label="Actions">
                <option value="delete" class="icon-trash">{'Delete selected users'|@translate}</option>
                <option value="status">{'Status'|@translate}</option>
                <option value="group_associate">{'associate to group'|translate}</option>
                <option value="group_dissociate">{'dissociate from group'|@translate}</option>
                <option value="enabled_high">{'High definition enabled'|@translate}</option>
                <option value="level">{'Privacy level'|@translate}</option>
                <option value="nb_image_page">{'Number of photos per page'|@translate}</option>
                <option value="theme">{'Theme'|@translate}</option>
                <option value="language">{'Language'|@translate}</option>
                <option value="recent_period">{'Recent period'|@translate}</option>
                <option value="expand">{'Expand all albums'|@translate}</option>
                {if $ACTIVATE_COMMENTS}
                <option value="show_nb_comments">{'Show number of comments'|@translate}</option>
                {/if}
                <option value="show_nb_hits">{'Show number of hits'|@translate}</option>
              </optgroup>
            </select>
          </div>
          {* delete *}
          <div id="action_delete" class="bulkAction">
            <div class="user-list-checkbox" name="confirm_deletion">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'Are you sure?'|@translate}</span>
            </div>
          </div>

          {* status *}
          <div id="action_status" class="bulkAction">
            <div class="user-action-select-container">
              <select class="user-action-select" name="status">
                {html_options options=$pref_status_options selected=$pref_status_selected}
              </select>
            </div>
          </div>

          {* group_associate *}
          <div id="action_group_associate" class="bulkAction">
            <div class="user-action-select-container">
              <select class="user-action-select" name="associate">
                {html_options options=$association_options selected=$associate_selected}
              </select>
            </div>
          </div>

          {* group_dissociate *}
          <div id="action_group_dissociate" class="bulkAction">
            <div class="user-action-select-container">
              <select class="user-action-select" name="dissociate">
                {html_options options=$association_options selected=$dissociate_selected}
              </select>
            </div>
          </div>

          {* enabled_high *}
          <div id="action_enabled_high" class="bulkAction yes_no_radio">
            <span class="user-list-checkbox" name="enabled_high_yes">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'Yes'|@translate}</span>
            </span>
            <span class="user-list-checkbox" data-selected="1" name="enabled_high_no">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'No'|@translate}</span>
            </span>
          </div>

          {* level *}
          <div id="action_level" class="bulkAction">
            <div class="user-action-select-container">
              <select class="user-action-select" name="level" size="1">
                {html_options options=$level_options selected=$level_selected}
              </select>
            </div>
          </div>

          {* nb_image_page *}
          <div id="action_nb_image_page" class="bulkAction">
            <div class="user-property-label photos-select-bar">{'Photos per page'|translate}
              <br/>
              <span class="nb-img-page-infos"></span>
              <div class="select-bar-wrapper">
                <div class="select-bar-container"></div>
              </div>
              <input name="nb_image_page" />
            </div>
          </div>

          {* theme *}
          <div id="action_theme" class="bulkAction">

            <div class="user-action-select-container">
              <select class="user-action-select" name="theme" size="1">
                {html_options options=$theme_options selected=$theme_selected}
              </select>
            </div>
          </div>

          {* language *}
          <div id="action_language" class="bulkAction">
            <div class="user-action-select-container">
              <select class="user-action-select" name="language" size="1">
                {html_options options=$language_options selected=$language_selected}
              </select>
            </div>
          </div>

          {* recent_period *}
          <div id="action_recent_period" class="bulkAction">
            <div class="user-property-label period-select-bar">{'Recent period'|translate}
              <br />
              <span class="recent_period_infos"></span>
              <div class="select-bar-wrapper">
                <div class="select-bar-container"></div>
              </div>
            </div>
          </div>

          {* expand *}
          <div id="action_expand" class="bulkAction yes_no_radio">
            <span class="user-list-checkbox" name="expand_yes">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'Yes'|@translate}</span>
            </span>
            <span class="user-list-checkbox" data-selected="1" name="expand_no">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'No'|@translate}</span>
            </span>
          </div>

          {* show_nb_comments *}
          <div id="action_show_nb_comments" class="bulkAction yes_no_radio">
            <span class="user-list-checkbox" name="show_nb_comments_yes">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'Yes'|@translate}</span>
            </span>
            <span class="user-list-checkbox" data-selected="1" name="show_nb_comments_no">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'No'|@translate}</span>
            </span>
          </div>

          {* show_nb_hits *}
          <div id="action_show_nb_hits" class="bulkAction yes_no_radio">
            <span class="user-list-checkbox" name="show_nb_hits_yes">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'Yes'|@translate}</span>
            </span>
            <span class="user-list-checkbox" data-selected="1" name="show_nb_hits_no">
              <span class="select-checkbox">
                <i class="icon-ok"></i>
              </span>
              <span class="user-list-checkbox-label">{'No'|@translate}</span>
            </span>
          </div>

          <p id="applyActionBlock" style="display:none" class="actionButtons">
            <input id="applyAction" class="submit" type="submit" value="{'Apply action'|@translate}" name="submit"> <span id="applyOnDetails"></span></input>
            <span id="applyActionLoading" style="display:none"><img src="themes/default/images/ajax-loader-small.gif"></span>
            <br />
            <span class="infos" style="display:inline-block;display:none;max-width:100%;margin:0;margin-top:30px;min-height:0;border-left: 2px solid #00FF00;">&#x2714; {'Users modified'|translate}</span>
          </p>
        </div> {* #permitActionUserList *}
      </fieldset>
    </div>
  </div>
</div>

<!-- User container template -->
<div id="template">
  <div class="user-container">
    <div class="user-col user-container-select tmp-select in-selection-mode user-first-col no-flex-grow">
      <div class="user-container-checkbox user-list-checkbox" name="select_container">
        <span class="select-checkbox">
          <i class="icon-ok"></i>
        </span>
      </div>
    </div>
    <div class="user-col user-container-edit tmp-edit not-in-selection-mode user-first-col no-flex-grow">
      <span class="icon-pencil"></span>
    </div>
    <div class="user-col user-container-initials no-flex-grow">
      <div class="user-container-initials-wrapper">
        <span><!-- initials --></span>
      </div>
    </div>
    <div class="user-col user-container-username">
      <span><!-- name --></span>
    </div>
    <div class="user-col user-container-status">
      <span><!-- status --></span>
    </div>
    <div class="user-col user-container-email not-in-selection-mode">
      <span><!-- email --></span>
    </div>
    {* <div class="user-col user-container-groups">
      <!-- groups -->
    </div> *}
    <div class="user-col user-container-registration">
      <div>
        {* <span class="icon-clock registration-clock"></span> *}
        <div class="user-container-registration-info-wrapper">
          {* <span class="user-container-registration-date"><b><!-- date DD/MM/YY --></b></span>
          <span class="user-container-registration-time"><!-- time HH:mm:ss --></span> *}
          <span class="user-container-registration-date-since"><!-- date_since --></span>
        </div>
      </div>
    </div>
    <div class="user-col user-container-groups">
      <!-- groups -->
    </div>
    <!-- edit-v2 -->
    <div class="user-col user-container-select user-container-select-v2 in-selection-mode user-first-col no-flex-grow">
      <div class="user-container-checkbox user-list-checkbox" name="select_container">
        <span class="select-checkbox">
          <i class="icon-ok"></i>
        </span>
      </div>
    </div>
    <div class="user-col user-container-edit user-container-edit-v2 not-in-selection-mode user-first-col no-flex-grow">
      <span class="icon-pencil"></span>
    </div>
  </div>
  <span class="user-groups group-primary"></span>
  <span class="user-groups group-bonus"></span>
  <div class="user-selected-item">
    <a class="icon-cancel"></a>
    <p></p>
  </div>
</div>

<div id="UserList" class="UserListPopIn">

  <div class="UserListPopInContainer">

    <a class="icon-cancel CloseUserList"></a>
    <div class="summary-properties-update-container">
      <div class="summary-properties-container">
        <div class="summary-container">
          <div class="user-property-initials">
            <div>
              <span class="icon-blue"><!-- Initials (JP) --></span>
            </div>
          </div>
          <div class="user-property-username">
            <span class="edit-username-title"><!-- Name (Jessy Pinkman) --></span>
            <span class="edit-username-specifier"><!-- You specifire (you) --></span>
            <span class="edit-username icon-pencil"></span>
          </div>
          <div class="user-property-username-change">
            <div class="summary-input-container">
              <input class="user-property-input user-property-input-username" value="" placeholder="{'Username'|@translate}" />
            </div>
            <span class="icon-ok edit-username-validate"></span>
            <span class="icon-cancel-circled edit-username-cancel"></span>
          </div>
          <div class="user-property-password-container">
            <div class="user-property-password edit-password">
              <p class="user-property-button"><span class="icon-key user-edit-icon"> </span>{'Change Password'|@translate}</p>
            </div>
            <div class="user-property-password-change">
              <div class="summary-input-container">
              <input class="user-property-input user-property-input-password" value="" placeholder="{'Password'|@translate}" />
              </div>
              <span class="icon-ok edit-password-validate"></span>
              <span class="icon-cancel-circled edit-password-cancel"></span>
            </div>
            <div class="user-property-permissions">
              <p class="user-property-button"> <span class="icon-lock user-edit-icon"> </span><a href="#" >{'Permissions'|@translate}</a></p>
            </div>
          </div>
          <div class="user-property-register-visit">
            <span class="user-property-register"><!-- Registered date XX/XX/XXXX --></span>
            <span class="icon-calendar"></span>
            <span class="user-property-last-visit"><!-- Last Visit date XX/XX/XXXX --></span>
          </div>
        </div>
        <div class="properties-container">
          <div class="user-property-column-title">
            <p>{'Properties'|@translate}</p>
          </div>
          <div class="user-property-email">
            <p class="user-property-label">{'Email Adress'|@translate}</p>
            <input type="text" class="user-property-input" value="contact@jessy-pinkman.com" />
          </div>
          <div class="user-property-status">
            <p class="user-property-label">{'Status'|@translate}</p>
            <div class="user-property-select-container">
              <select name="status" class="user-property-select">
                <option value="webmaster">{'user_status_webmaster'|@translate}</option>
                <option value="admin">{'user_status_admin'|@translate}</option>
                <option value="normal">{'user_status_normal'|@translate}</option>
                <option value="generic">{'user_status_generic'|@translate}</option>
                <option value="guest">{'user_status_guest'|@translate}</option>
              </select>
            </div>
          </div>
          <div class="user-property-level">
            <p class="user-property-label">{'Privacy level'|@translate}</p>
            <div class="user-property-select-container">
              <select name="privacy" class="user-property-select">
                <option value="0">{'Level 0'|@translate}</option>
                <option value="1">{'Level 1'|@translate}</option>
                <option value="2">{'Level 2'|@translate}</option>
                <option value="4">{'Level 4'|@translate}</option>
                <option value="8">{'Level 8'|@translate}</option>
              </select>
            </div>
          </div>
          <div class="user-property-group-container">
            <p class="user-property-label">{'Groups'|@translate}</p>
            <div class="user-property-select-container user-property-group">
              <select class="user-property-select" data-selectize="groups" placeholder="{'Select groups or type them'|translate}" 
                name="group_id[]" multiple style="box-sizing:border-box;"></select>
            </div>
          </div>

          <div class="user-list-checkbox" name="hd_enabled">
            <span class="select-checkbox">
              <i class="icon-ok"></i>
            </span>
            <span class="user-list-checkbox-label">{'High definition enabled'|translate}</span>
          </div>
        </div>
      </div>
      <div class="update-container" style="display:flex;flex-direction:column">
        <div style="display:flex;justify-content:space-between;margin-bottom: 10px;">
          <div>
            <span class="update-user-button">{'Update'|@translate}</span>
            <span class="close-update-button">{'Close'|@translate}</span>
            <span class="update-user-success icon-green">{'User updated'|@translate}</span>
          </div>
          <div>
            <span class="delete-user-button icon-trash">{'Delete user'|@translate}</span>
          </div>
        </div>
        <div>
          <span class="update-user-fail icon-red"></span>
        </div>
      </div>
    </div>
    <div class="preferences-container">
      <div class="user-property-column-title">
        <p>{'Preferences'|translate}</p>
      </div>
      <div class="user-property-label photos-select-bar">{'Photos per page'|translate}
        <span class="nb-img-page-infos"></span>
        <div class="select-bar-wrapper">
          <div class="select-bar-container"></div>
        </div>
        <input name="recent_period" />
      </div>
      <div class="user-property-theme" style="margin-top: 37px;">
        <p class="user-property-label">{'Theme'|@translate}</p>
        <div class="user-property-select-container">
          <select name="privacy" class="user-property-select">
            {html_options options=$theme_options selected=$theme_selected}
          </select>
        </div>
      </div>
      <div class="user-property-lang">
        <p class="user-property-label">{'Language'|@translate}</p>
        <div class="user-property-select-container">
          <select name="privacy" class="user-property-select">
            {html_options options=$language_options selected=$language_selected}
          </select>
        </div>
      </div>
      <div class="user-property-label period-select-bar">{'Recent period'|translate}
        <span class="recent_period_infos"></span>
        <div class="select-bar-wrapper">
          <div class="select-bar-container"></div>
        </div>
      </div>
      
      <div class="user-list-checkbox" name="expand_all_albums">
        <span class="select-checkbox">
          <i class="icon-ok"></i>
        </span>
        <span class="user-list-checkbox-label">{'Expand all albums'|translate}</span>
      </div>
      <div class="user-list-checkbox" name="show_nb_comments">
        <span class="select-checkbox">
          <i class="icon-ok"></i>
        </span>
        <span class="user-list-checkbox-label">{'Show number of comments'|translate}</span>
      </div>
      <div class="user-list-checkbox" name="show_nb_hits">
        <span class="select-checkbox">
          <i class="icon-ok"></i>
        </span>
        <span class="user-list-checkbox-label">{'Show number of hits'|translate}</span>
      </div>
    </div> 
  </div>
</div>


<div id="GuestUserList" class="UserListPopIn">

  <div class="GuestUserListPopInContainer">

    <a class="icon-cancel CloseUserList CloseGuestUserList"></a>
    <div id="guest-msg" style="background-color:#B9E2F8;padding:5;border-left:3px solid blue;display:flex;align-items:center;margin-bottom:30px">
      <span class="icon-info-circled-1" style="background-color:#B9E2F8;color:#26409D;font-size:3em"></span><span style="font-size:1.1em;color:#26409D;font-weight:bold;">{'Users not logged in will have these settings applied, these settings are used by default for new users'|@translate}</span>
    </div>
    <div style='display:flex;'>
      <div class="summary-properties-update-container">
      <div class="summary-properties-container">
        <div class="summary-container">
          <div class="user-property-initials">
            <div>
              <span class="icon-blue"><!-- initials -> JP --></span>
            </div>
          </div>
          <div class="user-property-username">
            <span class="edit-username-title"><!-- name -> Jessy Pinkman --></span>
            <span class="edit-username-specifier"><!-- you specifier(you) --></span>
          </div>
          <div class="user-property-username-change">
            <div class="summary-input-container">
              <input class="user-property-input user-property-input-username" value="" placeholder="{'Username'|@translate}" />
            </div>
            <span class="icon-ok edit-username-validate"></span>
            <span class="icon-cancel-circled edit-username-cancel"></span>
          </div>
          <div class="user-property-password-container">
            <div class="user-property-password edit-password">
              <p class="user-property-button unavailable"><span class="icon-key user-edit-icon"></span>{'Change Password'|@translate}</p>
            </div>
            <div class="user-property-password-change">
              <div class="summary-input-container">
              <input class="user-property-input user-property-input-password" value="" placeholder="{'Password'|@translate}" />
              </div>
              <span class="icon-ok edit-password-validate"></span>
              <span class="icon-cancel-circled edit-password-cancel"></span>
            </div>
            <div class="user-property-permissions">
              <p class="user-property-button"><span class="icon-lock user-edit-icon"></span><a href="admin.php?page=user_perm&user_id={$guest_id}">{'Permissions'|@translate}</a></p>
            </div>
          </div>
        </div>
        <div class="properties-container">
          <div class="user-property-column-title">
            <p>{'Properties'|@translate}</p>
          </div>
          <div class="user-property-email">
            <p class="user-property-label">{'Email Adress'|@translate}</p>
            <input type="text" class="user-property-input" value="N/A" readonly />
          </div>
          <div class="user-property-status">
            <p class="user-property-label">{'Status'|@translate}</p>
            <div class="user-property-select-container">
              <select name="status" class="user-property-select">
                <option value="guest">{'Guest'|@translate}</option>
              </select>
            </div>
          </div>
          <div class="user-property-level">
            <p class="user-property-label">{'Privacy Level'|@translate}</p>
            <div class="user-property-select-container">
              <select name="privacy" class="user-property-select">
                <option value="0">{'Level 0'|@translate}</option>
                <option value="1">{'Level 1'|@translate}</option>
                <option value="2">{'Level 2'|@translate}</option>
                <option value="4">{'Level 4'|@translate}</option>
                <option value="8">{'Level 8'|@translate}</option>
              </select>
            </div>
          </div>
          <div class="user-property-group-container">
            <p class="user-property-label">{'Groups'|@translate}</p>
            <div class="user-property-select-container user-property-group">
              <select class="user-property-select" data-selectize="groups" placeholder="{'Select groups or type them'|translate}" 
                name="group_id[]" multiple style="box-sizing:border-box;"></select>
            </div>
          </div>

          <div class="user-list-checkbox" name="hd_enabled">
            <span class="select-checkbox">
              <i class="icon-ok"></i>
            </span>
            <span class="user-list-checkbox-label">{'High definition enabled'|translate}</span>
          </div>
        </div>
      </div>
      <div class="update-container">
        <div style="display:flex;flex-direction:column">
          <div style="display:flex;margin-bottom: 30px">
            <span class="update-user-button">{'Update'|@translate}</span>
            <span class="close-update-button">{'Close'|@translate}</span>
            <span class="update-user-success icon-green">{'User updated'|@translate}</span>
          </div>
          <div>
            <span class="update-user-fail icon-red"></span>
          </div>
        </div>
      </div>
      </div>
      <div class="preferences-container">
        <div class="user-property-column-title">
          <p>{'Preferences'|translate}</p>
        </div>
        <div class="user-property-label photos-select-bar">{'Photos per page'|translate}
          <span class="nb-img-page-infos"></span>
          <div class="select-bar-wrapper">
            <div class="select-bar-container"></div>
          </div>
          <input name="recent_period" />
        </div>
        <div class="user-property-theme">
          <p class="user-property-label">{'Theme'|@translate}</p>
          <div class="user-property-select-container">
            <select name="privacy" class="user-property-select">
              {html_options options=$theme_options selected=$theme_selected}
            </select>
          </div>
        </div>
        <div class="user-property-lang">
          <p class="user-property-label">{'Language'|@translate}</p>
          <div class="user-property-select-container">
            <select name="privacy" class="user-property-select">
              {html_options options=$language_options selected=$language_selected}
            </select>
          </div>
        </div>
        <div class="user-property-label period-select-bar">{'Recent period'|translate}
          <span class="recent_period_infos"><!-- 7 days --></span>
          <div class="select-bar-wrapper">
            <div class="select-bar-container"></div>
          </div>
        </div>

        <div class="user-list-checkbox" name="expand_all_albums">
          <span class="select-checkbox">
            <i class="icon-ok"></i>
          </span>
          <span class="user-list-checkbox-label">{'Expand all albums'|translate}</span>
        </div>
        <div class="user-list-checkbox" name="show_nb_comments">
          <span class="select-checkbox">
            <i class="icon-ok"></i>
          </span>
          <span class="user-list-checkbox-label">{'Show number of comments'|translate}</span>
        </div>
        <div class="user-list-checkbox" name="show_nb_hits">
          <span class="select-checkbox">
            <i class="icon-ok"></i>
          </span>
          <span class="user-list-checkbox-label">{'Show number of hits'|translate}</span>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="AddUser" class="UserListPopIn">
  <div class="AddUserPopInContainer">
    <a class="icon-cancel CloseUserList CloseAddUser"></a>
    
    <div class="AddIconContainer">
      <span class="AddIcon icon-blue icon-plus-circled"></span>
    </div>
    <div class="AddIconTitle">
      <span>{'Add a new user'|@translate}</span>
    </div>
    <div class="AddUserInputContainer">
      <label class="AddUserLabel AddUserLabelUsername">{'Username'|@translate}
        <input class="AddUserInput" />
      </label>
    </div>

    <div class="AddUserInputContainer">
      <div class="AddUserPasswordWrapper">
        <label for="AddUserPassword" class="AddUserLabel AddUserLabelPassword">{'Password'|@translate}</label>
        <span id="show_password" class="icon-eye">{'Show'|@translate}</span>
      </div>
      <input id="AddUserPassword" class="AddUserInput" type="password"/>

      <div class="AddUserGenPassword">
        <span class="icon-dice-solid"></span><span>{'Generate random password'|@translate}</span>
      </div>
    </div>

    <div class="AddUserInputContainer">
      <label class="AddUserLabel AddUserLabelEmail">{'Email'|@translate}
        <input class="AddUserInput" />
      </label>
    </div>

    <div class="user-list-checkbox" name="send_by_email">
      <span class="select-checkbox">
        <i class="icon-ok"></i>
      </span>
      <span class="user-list-checkbox-label">{'Send connection settings by email'|translate}</span>
    </div>

    <div class="AddUserErrors icon-red">
      <p>X</p>
    </div>

    <div class="AddUserSubmit">
      <span class="icon-plus"></span><span>{'Add User'|@translate}</span>
    </div>

    <div class="AddUserCancel" style="display:none;">
      <span>{'Cancel'|@translate}</span>
    </div>
  </div>
</div>

<style>

/* general */
.no-flex-grow {
    flex-grow:0 !important;
}

#template {
    display:none;
}

/* selection mode */

.user-selection-content {
	margin-top: 90px;
	padding: 5px;
}

#user-table #selection-mode-block{
  display:none;
  position: relative;
  width: 223px;
  top: -20px;
  min-height: 100%;
}

#forbidAction {
  padding:5px;
}
/* user header */

.user-manager-header {
	display: flex;
	flex-wrap: nowrap;
	align-items: center;
	overflow: hidden;
  padding-bottom:5px;
}

.user-header-button {
  position:relative;
}

.user-header-button-label {
	position: relative;
	padding: 10px;
	background-color: #fafafa;
	box-shadow: 0px 2px #00000024;
	border-radius: 5px;
	font-weight: bold;
	display: flex;
	align-items: baseline;
	cursor: pointer;
}


.user-header-button-label p {
  margin:0;
}

#AddUserSuccess {
  display:none;
  position: absolute;
  top:80px;
  right:30px;
  font-weight:bold;
}

#AddUserSuccess span {
  color: #0a0;
}

#AddUserSuccess label {
  padding: 10px;
  background-color:  #c2f5c2;
  border-left: 2px solid #00FF00;
  cursor: default;
  color: #0a0;
}

#AddUserSuccess .edit-now {
  color: #3a3a3a;
  cursor: pointer;
  margin-left:10px;
}

/* filters bar */

#user_search {
    width: 100px;
}

.advanced-filter-date {
  width: auto;
}

/* Pagination */
.user-pagination {
    margin: 0;
    display: flex;
    padding: 0;
    justify-content: space-between;
    align-items: center;
}

.selected-pagination {
  background: #ffd2a1;
}

/* User Table */
#user-table {
    margin-left:30px;
    display:flex;
    flex-wrap:nowrap;
    min-height: calc(100vh - 216px);
}

#user-table-content {
    max-width:100%;
    flex-grow:1;
    display:flex;
    flex-direction:column;
    margin-right:30px;
}

.user-container-header {
    display:flex;
    text-align:left;
    font-size:1.3em;
    font-weight:bold;
    margin-top:20px;
    color:#9e9e9e;
}

.user-header-col {
    height:50px;
    flex-grow:1;
}

/* User Container */
.user-container {
    display:flex;
    width:100%;
    height:50px;
    background-color:#F3F3F3;
    font-weight:bold;
    border-radius:10px;
    margin-bottom:10px;
    transition: background-color 500ms linear;
    box-shadow: 0px 2px 5px #00000024;
}

.user-header-select,
.user-container-select,
.user-container-edit {
    width:40px;
}

.user-header-initials,
.user-container-initials {
    width:60px;
}

.user-header-username{
  width: 20%;
  max-width: 200px;
}
.user-container-username {
  width: 20%;
  max-width: 150px;

  white-space: nowrap;

  overflow: hidden;
  text-overflow: ellipsis;

  padding-right: 10px;

}

.user-container-username span {
  max-width: 100%;

  overflow: hidden;
  text-overflow: ellipsis;
}

.user-header-status,
.user-container-status {
    width:10%;
    max-width: 140px;
}

.user-header-email,
.user-container-email {
    width:20%;
    max-width: 200px;
}

.user-header-groups,
.user-container-groups {
    width:20%;
    max-width: 900px;
    min-width: 100px;
}

.user-header-col.user-header-registration,
.user-col.user-container-registration {
  flex-grow: 0;
}

.user-groups .group-primary {
  width: 100px;
}

.user-header-registration,
.user-container-registration {
    width: 10% !important;
    max-width: 700px;
    margin-left: auto;
}

.user-col {
    text-align: left;
    padding: 0;
    display:flex;
    align-items:center;
    flex-grow:1;
}

.user-first-col {
    border-top-left-radius: 15%;
    border-bottom-left-radius: 15%;
    cursor:pointer;
}

.user-first-col:hover {
    background-color:#FFC276;
}

.user-first-col:hover span{
    color: #000;
}

.user-container-checkbox.user-list-checkbox {
    margin-bottom:0px;
}


.user-container-checkbox.user-list-checkbox .select-checkbox {
  border: solid #E6E6E6 2px;
  background-color: #F3F3F3;
}


.user-container.container-selected .user-container-checkbox.user-list-checkbox .select-checkbox {
  background-color: #ffa646;
  border: solid #ffa646 2px;
}

.user-container-checkbox.user-list-checkbox i {
    margin-left:7px;
}

.user-container-select {
    display:flex;
    justify-content:center;
    align-items:center;
}

.user-container-select span {
    font-size:1.5em;
    border: 1px solid #E6E6E6;
    border-radius:50%;
    background-color:#F3F3F3;
    width:27px;
}

.user-container-select span > i {
    display:none;
}

.user-container-edit {
  justify-content: center;
}

.user-container-edit span {
    font-weight:bold;
    font-size:1.5em;
    cursor:pointer;
    width:27px;
}

.user-container-initials-wrapper {
    padding-left:10px;
}

.user-container-initials-wrapper > span {
    border-radius:50%;
    padding:5px;
    width:40px;
    height:40px;
    display:inline-block;
    text-align:center;
    font-size:1.5em;
    line-height:1.9em;
}

.user-container-status {
    text-transform:capitalize;
}

.user-container-registration {
    width:15%;
}

.user-container-registration > div {
    display:flex;
}

.registration-clock {
    background:#E3E5E5;
    padding:5px;
    width:50%;
    height:50%;
    border-radius:30px;
    margin-right:5px;
    font-size:1.5em;
}

.user-container-registration-info-wrapper {
    display:flex;
    flex-direction:column;
}

.user-groups {
    margin-right: 5px;
    border-radius:9999px;
    padding: 10px 15px;
}

.group-primary {
    max-width:30%;
    text-overflow: ellipsis;
    overflow:hidden;
    white-space:nowrap;
}

/* User container selected */

.user-container.container-selected {
    display:flex;
    width:100%;
    height:80px;
    background-color:#FFD9A7;
    font-weight:bold;
    border-radius:10px;
    margin-bottom:20px;
}


.user-container.container-selected .user-container-initials-wrapper > span {
  background-color: #FF7B00;
  color:#FEE7BD;
}

.user-container.container-selected .user-groups,
.user-container.container-selected .registration-clock {
  background-color: #FEE7C8;
  color:#FF7B00;
}

/* User Edit Pop-in */
#UserList {
    font-size:1em;
}

.UserListPopIn{
    position: fixed;
    z-index: 100;
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%;
    overflow: auto; 
    background-color: rgba(0,0,0,0.7);
}

.UserListPopInContainer{
    display:block;
    position:absolute;
    left:50%;
    top: 50%;
    transform:translate(-50%, -48%);
    text-align:left;
    padding:20px;
    display:flex;
    background-color:white;
    width:870px
}

.summary-properties-update-container {
    height:100%;
    display:flex;
    flex-direction:column
}

.summary-properties-container {
    display:flex;
    flex-grow:1;
}

.summary-container {
    width:250px;
    display:flex;
    flex-direction:column;
    align-items:center;
    padding:5px;
    padding-right:20px;
}

.properties-container {
    width:250px;
    border-left:solid 1px #ddd;
    padding: 0 20px
}

.update-container {
    border-top:solid 1px #ddd;
    padding-right:20px;
    padding-top:30px;
}

.preferences-container {
    width:250px;
    padding-left:20px;
    border-left: solid 1px #ddd;
}

/* general pop in rules */
.user-property-column-title {
    color:#353535;
    font-weight:bold;
    margin-bottom:15px;
    font-size:1.4em;
}

.user-property-column-title > p {
    margin:0;
}


.user-property-label {
    color:#A4A4A4;
    font-weight:bold;
    font-size:1.1em;
    margin-bottom:5px;
}

.user-property-label span,
.dates-infos {
	color: #ff7700;
	font-weight: bold;
  margin-left: 15px;
}


.user-property-input {
    width: 100%;
    box-sizing:border-box;
    font-size:1.1em;
    padding:8px 16px;
    border:none;
    color:#353535;
    background-color:#F3F3F3;
}

.user-property-input[type="text"] {
    background-color:#F3F3F3;
}


.user-property-button {
    margin-top:0;
    font-size:1.1em;
    color:#353535;
    margin-bottom:15px;
    cursor:pointer;
    padding:8px;
    border:none;
    color:#353535;
    background-color:#F3F3F3;
}

.user-property-select {
    box-sizing: border-box;
    background-color:#F3F3F3;
    color:#353535;
    -webkit-appearance:none;
    border:none;
    width:100%;
    padding: 10px;
    font-size:1.1em;
}

.user-property-select-container {
    margin-bottom: 15px;
}

.user-property-select-container::before {
  margin-top: 10px;
  margin-left: 220px;
}

.advanced-filter-select-container {
  position: relative;
  text-align:left;
  width:85%;
}

.user-action-select-container {
  position:relative;
}


.select-bar-wrapper {
    padding-left:10px;
    margin-top: 20px;
    margin-bottom: 30px;
}

.select-bar-wrapper .select-bar-container {
  height: 2px;
}

.select-bar-wrapper .ui-slider-horizontal .ui-slider-handle{
    background-color:#ffaf58;
    border: 1px solid #ffaf58;
    border-radius:25px;
    top: -.7em !important;
    width: 1.4em;
    height: 1.4em;
}

.select-bar-wrapper .ui-slider-horizontal .ui-slider-range {
  background-color: #ffaf58;
}

.select-bar-wrapper .ui-slider-horizontal{
    background-color:#e3e3e3;
    border:none;
    border-radius:25px;
}

.user-list-checkbox {
    margin-bottom:15px;
}

.user-list-checkbox {
  user-select: none;
}

.user-list-checkbox i {
    margin-left:7px;
}

.user-list-checkbox-label {
    margin-left: 5px;
    vertical-align:top;
    font-size:1em;
    cursor:pointer;
}

/* summary section */
.user-property-initials {
    margin-bottom: 40px;
}

.user-property-initials > div {
    padding-left:10px;
}

.user-property-initials span{
    border-radius:50%;
    padding:5px;
    width:100px;
    height:100px;
    display:inline-block;
    text-align:center;
    font-size:4em;
    line-height:1.9em;
    font-weight:bold;
}

.user-property-username {
    font-weight:bold;
    margin-bottom:34px;
    height:30px;
}

.user-property-username-change {
    justify-content:center;
    align-items:center;
    display:none;
    margin-bottom:25px;
}

.user-property-password-change {
  display:none;
  margin-bottom: 20px;
}

.summary-input-container {
  width:171px;
  display:inline-block;
}

.edit-username {
    font-size:1.4em;
    cursor:pointer;
}

.edit-username-title {
    font-size:1.4em;
    color:#353535;
}

.edit-username-specifier {
    font-size:1.5em;
    color:#A4A4A4;
}

.user-property-input.user-property-input-username {
    border: solid 2px #ffa744;
    background: none;
    padding: 9px;
}

.user-property-input.user-property-input-username:hover {
    background-color: #f0f0f0 !important;
}

.user-property-password-container {
    display:flex;
    flex-direction:column;
    margin-bottom:30px;
    width:100%;
}

.edit-username-validate,
.edit-password-validate {
    display: block;
    margin: auto 5px;
    cursor: pointer;
    background-color: #ffa744;
    color: #3c3c3c;
    font-size: 17px;
    font-weight: 700;
    padding: 7px;
}

.edit-username-validate:hover,
.edit-password-validate:hover {
    background-color: #f70;
    color: #000;
    cursor: pointer;
}

.edit-username-cancel,
.edit-password-cancel {
    cursor:pointer;
    font-size:22px;
    padding-top: 4px;
}

.edit-username-cancel:hover,
.edit-password-cancel:hover {
    color: #ff7700;
}

.user-property-input.user-property-input-password {
    border: solid 2px #ffa744;
    background: none;
    padding: 9px;
}

.user-property-input.user-property-input-password:hover {
    background-color: #f0f0f0 !important;
}

.user-property-register-visit {
    color:#A4A4A4;
    font-weight:bold;
    font-size:1.2em;
    display:flex;
    align-items:center;
    justify-content:center;
}

.user-property-register-visit span {
    margin:0;
}


.user-property-register, .user-property-last-visit {
  min-width: 80px;
  font-size: 15px;
}

.user-property-register-visit .icon-calendar {
    margin:0;
    font-size:1.8em;
    color: #4C4C4C;
}

/* properties */

.user-property-group-container {
  margin-bottom:20px;
}


.user-property-select > .selectize-input.items {
    padding:0;
}

.user-property-group .selectize-input.items {
    border:none;
    background-color: #F3F3F3;
}


/* preferences */

.nb-img-page-infos {
    color:#353535;
    font-weight:normal;
}

.photos-select-bar input {
    display:none;
}

.recent_period_infos {
    color:#353535;
    font-weight:normal;
}

/* update */

.update-user-button {
    cursor:pointer;
    color:#353535;
    padding:10px 20px;
    font-size:1.1em;
    font-weight:bold;

    background-color: #ffa744;
    color: #3c3c3c;
}

.update-user-button:hover {
    background-color: #ff7700;
}

.update-user-button.can-update {
    background-color: #FFC275;
    color: white;
}

.close-update-button {
    cursor: pointer;
    color: #A4A4A4;
    padding:10px 20px;
    font-size:1.1em;
    font-weight:bold;
}

.delete-user-button {
    cursor:pointer;
    color:#353535;
    padding:10px 20px;
    background-color: #F3F3F3;
    font-size:1.1em;
    font-weight:bold;
}

.update-user-success {
    padding:10px;
    display:none;s
    background-color:  #c2f5c2;
    color: #0a0;
}

.update-user-fail {
    padding:10px;
    display:none
}

/* Guest Pop in */

#GuestUserList {
  display:none;
}

.GuestUserListPopIn {
    position: fixed;
    z-index: 100;
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%;
    overflow: auto; 
    background-color: rgba(0,0,0,0.7);
}


.GuestUserListPopInContainer{
    display:flex;
    position:absolute;
    left:50%;
    top: 50%;
    transform:translate(-50%, -48%);
    text-align:left;
    padding:10px;
    display:flex;
    background-color:white;
    padding:30px;
    width:1020px;
    flex-direction:column;
    border-radius:15px;
}

.unavailable {
  color:#CBCBCB;
}

/* Add User Pop In */

#AddUser {
  display:none;
}

.AddUserPopInContainer{
    display:flex;
    position:absolute;
    left:50%;
    top: 50%;
    transform:translate(-50%, -48%);
    text-align:left;
    background-color:white;
    padding:40px;
    flex-direction:column;
    border-radius:15px;
    align-items:center;
    width: min-content;
}

.AddIconContainer {
}

.AddIcon {
  border-radius:9999px;
  padding:10px;
  font-size: 2em;
}

.AddIconTitle {
  font-size:1.7em;
  font-weight:bold;
  color: #000000;
  margin-bottom:20px;
  margin-top:15px;
}

.AddUserInputContainer {
  display: flex;
  flex-direction: column;
  margin: 20px 0px;
  width:100%;
}

.AddUserLabel {
  display:block;
  color: #3E3E3E;
  font-size:1.3em;
}

.AddUserInput {
  display:block;
  background-color:white;
  border: solid 1px #D4D4D4;
  font-size:1.3em;
  padding: 10px 5px;
}

.AddUserInput[type="password"],
.AddUserInput[type="text"] {
  background-color:white;
}

.AddUserPasswordWrapper {
  display:flex;
  justify-content:space-between;
}

.AddUserPasswordWrapper span {
  font-size:1.3em;
  cursor:pointer;
}


.AddUserPasswordWrapper:hover {
  color:#ffa646;
}

.AddUserGenPassword {
  margin-top: 5px;
  font-size: 1.1em;
  cursor:pointer;
}
.AddUserGenPassword:hover, .AddUserGenPassword:active {
  color:#ffa646;
}

.AddUserGenPassword span {
  margin-right:10px;
}

.AddUserErrors {
  visibility:hidden;
  width:100%;
  padding:5px;
  border-left:solid 3px red;
}

.AddUserErrors p {
	font-size: 14px;
	font-weight: bold;
	padding-left: 10px;
	height: 40px;
}

.AddUserSubmit {
  cursor:pointer;
  font-weight:bold;
  color: #3F3E40;
  background-color: #FFA836;
  padding: 10px;
  margin: 20px;
  font-size:1em;
  margin-bottom:0;
}

.AddUserCancel {
  color: #3F3E40;
  font-weight: bold;
  cursor: pointer;
  font-size:1em;
}

/* Selectize Inputs (groups) */

#UserList .item,
#UserList .item.active,
#GuestUserList .item,
#GuestUserList .item.active {
  background-image:none;
  background-color: #ffa744;
  border-color: black;
}


#UserList .item .remove,
#GuestUserList .item .remove {
  border-color: black;
}

/* selection panel */
#permitActionUserList .user-list-checkbox i {
	margin-left: 0px;
}

.user-selected-item {
	display: flex;
	margin: 10px;
	text-align: start;
}

.user-selected-item p {
	width: 85%;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	color: #a0a0a0;
	margin: 0;
}

.selection-other-users {
  display:block;
	color: #ffa646;
	font-weight: bold;
	font-size: 15px;
}

.user-action-select {
	background: white;
	-webkit-appearance: none;
	padding: 5px 10px;
  width:100%;
}

.user-action-select[name="selectAction"] {
  margin-bottom:30px;
}

.search-icon {
  top: 20px;
  z-index: 13;
}

/*----------------------
Advanced filter
----------------------*/

.filter-div {
  margin-left: 500px;
}

#advanced_filter_button {

  width: 100px;

  position: absolute;
  z-index: 2;
  right: 542px;
  top: 192px;


  cursor:pointer;
  padding:10px;
  background-color:#F3F3F3;
  margin-right:10px;
}

#search-user {
  position: absolute;
  z-index: 2;
  right: 400px;
  top: 188px;
}

.extended-filter-btn {
  height: 25px;
}

#advanced-filter-container {
  display:none;
  background-color:#F3F3F3;
  padding:15px;
  font-size:1em;
}

.advanced-filters-header {
  display:flex;
  justify-content:space-between;
  margin-bottom:10px;
}

.advanced-filter-title {
  font-weight:bold;
  color:#3e3e3e;
}

.advanced-filters {
  display:flex;
  padding:5px;
}

.advanced-filter-status, 
.advanced-filter-group, 
.advanced-filter-level {
  min-width: 130px;
  width: 16%;
}

.advanced-filter-date {
  width: 40%;
  min-width: 330px;
  margin: 0 auto 0 auto;

  display: flex;
  flex-direction: column;
  justify-content: center;
} 

.advanced-filter-date-title {
  width: 105%;
  display: flex;
  flex-direction: row;

  justify-content: center;
}

.select-bar-wrapper {
  margin-top: 12px;
}

.advanced-filter-date {
  padding-right:15px;
}

.advanced-filter-label {
  text-align:left;
  display:block;
  color: #3f3f3f;
  margin-bottom:5px;
}

.advanced-filter-select {
  display:block;
  border: solid 1px #D4D4D4;
}

.advanced-filter-close {
  font-size: 1.8em;
  color: #C5C5C5;
  cursor:pointer;
}

.user-update-spinner {
  display:none;
}

.UserListPopInContainer .selectize-dropdown-content .option{
  font-size: 0.9em;
  margin-bottom:5px;
}

#permitActionUserList #applyActionBlock {
  margin: 30px 0 0 0;
  display:flex;
  flex-direction:column;
}

.yes_no_radio .user-list-checkbox{
  cursor:pointer;
}

.yes_no_radio .user-list-checkbox .user-list-checkbox-label {
  margin-left: 0;
  margin-right: 10px;
}

#user-table #action {
  padding: 0;
}

.user-header-initials {
  width: 10px;
}

.group-bonus {
  color: #000;
  background: #DDDDDD;
}

/*View Selector*/

.selectedAlbum-first {
  margin-left: 0px;
}

.UserViewSelector {
  padding: 6px 0px;
  margin-right: 0px;
  border-radius: 10px;
  background: #fafafa !important;

  position: absolute;
  z-index: 2;
  right: 280px;
}

.UserViewSelector span {
  border-radius: 0;
  padding: 6px;
}

/* Should be done with :first-child and :last-child but doesn't work */

.UserViewSelector label span.firstIcon{
  border-radius: 7px 0 0 7px;
}

.UserViewSelector label span.lastIcon{
  border-radius: 0 7px 7px 0;
}

.icon-th-large, .icon-th-list, .icon-pause {
  padding: 10px;
  font-size: 19px;

  transition: 0.3s;
}

.UserViewSelector input:checked + label{
  background: transparent;
  color: white !important;
}

.UserViewSelector input:checked + label span{
  background: orange;
}

.switchLayout {
  display: none;
}


/* Tile View */

.tileView {
  display: flex;
  flex-direction: row;

  flex-wrap: wrap;

  margin-bottom: 20px;
}

.tileView .user-container{
  display: flex;
  flex-direction: column;

  width: 220px;
  height: 250px;

  margin: 20px 20px 20px 0;
}

.tileView .user-container-registration {
  display: none;
}

.tileView .user-container-status,
.tileView .user-container-username {
  margin: 0 auto;
  justify-content: center;
  max-height: 18px;
}

.tileView .user-container-username {
  margin-top: 10px;
  margin-bottom: 5px;
  color: black;
  font-size: 13px;

  height: 15px;

  width: 140px;
  overflow: hidden;
}

.tileView .user-container-username span {
  max-width: 140px;
  overflow: hidden;
  text-overflow: ellipsis;

  text-align: left;
  white-space: nowrap;
}

.tileView .user-container-email {
  margin: 10px auto;
  justify-content: center;
  max-height: 40px;
}

.tileView .user-container-groups {
  margin: auto auto 15px auto;
  justify-content: center;
  max-height: 40px;
  width: 90%;
  min-width: 0px;
}

.tileView .group-primary {
  max-width: 45%;
  font-size: 11px;
}

.tileView .group-bonus {
  font-size: 11px;
}

.tileView .user-groups {
  padding: 5px 10px;
}

.tileView .user-container .user-container-edit,
.tileView .user-container .user-container-select {
  height: 40px;
  width: 40px;
  margin: 5px 0 0 5px;
  border-radius: 50%;

  display: flex;
  justify-content: center;
  align-items: center;
}

.tileView .user-container .user-container-checkbox {
  transform: translate3d(-1px, 1px, 0px);
}

.tileView .user-container-initials-wrapper {
    padding-left:0px;
}

.tileView .user-container-initials {
  margin: -10px auto 0 auto;
  justify-content: center;
  max-height: 40px;
}

.hide {
  display: none !important;
}

.tileView .user-container-edit {
  color: transparent;
}

.tileView .user-container:hover .user-container-edit{
  color: #777;
}

.tileView .user-container-username {
  padding-right: 0;
}

.tileView .user-container .tmp-edit {
  display: flex;
}

.tileView #toggleSelectionMode:checked .tmp-edit {
  display: none !important;
}

.tileView #toggleSelectionMode:checked .tmp-select {
  display: flex !important;
}

/* Compact View */

.compactView {
  display: flex;

  flex-direction: row;
  flex-wrap: wrap;

  margin-bottom: 35px;
}

.compactView .user-container {
  height: 50px;
  padding: 0;

  width: min-content;

  margin: 20px 20px 0  0 !important;
  border-radius: 25px;
}

.compactView .user-container .user-container-status,
.compactView .user-container .user-container-email,
.compactView .user-container .user-container-groups,
.compactView .user-container .user-container-registration {
  display: none !important;
}

.compactView .user-container .tmp-select,
.compactView .user-container .tmp-edit {
  display: none !important;
}

.compactView .user-container .user-container-edit-v2,
.compactView .user-container .user-container-select-v2 {
  display: flex;
} 


.compactView .user-container-username  {
  width: max-content;
  min-width: auto;

  margin-right: 10px ;
}

.compactView .user-container-initials-wrapper {
  padding-left: 0;
}

.compactView .user-container .user-container-edit,
.compactView .user-container .user-container-select {
  height: 50px;
  width: 50px;
  border-radius: 50%;

  display: flex;
  justify-content: center;
  align-items: center;
}

.compactView .user-container-initials {
  width: 60px;
}

.compactView .user-container .user-container-checkbox {
  transform: translate3d(-1px, 1px, 0px);
}

.compactView .group-primary {
  max-width: 100px;
}

.compactView .user-container-username {
  padding-right: 0;
}

/* Line View */

.lineView {
  margin-bottom: 20px;
}

.lineView .user-container.container-selected {
  height: 50px;
  margin-bottom: 10px;
}

.lineView .user-container-initials-wrapper > span {
  padding: 0px;
  height: 40px;
  width: 40px;

  display: flex;
  justify-content: center;
  align-items: center;
}

.lineView .user-container .tmp-edit {
  display: flex;
}

.lineView #toggleSelectionMode:checked .tmp-edit {
  display: none !important;
}

.lineView #toggleSelectionMode:checked .tmp-select {
  display: flex !important;
}

.lineView .group-primary{
  margin-right: 15px;
}


/* User Edit */

.user-edit-icon {
  margin-right: 5px;
}

.selectize-input.items .item {
  color: #000 !important;
}


</style>
