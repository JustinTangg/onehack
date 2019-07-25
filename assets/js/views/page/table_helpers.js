var $ = require("jquery");

export function setup_table_with_data(
  table_name,
  page_length,
  data_source,
  columns
) {
  var pixels = page_length * 37;
  var table = $(table_name).DataTable({
    lengthChange: false,
    dom: "Bfrtip",
    stateSave: false,
    select: true,
    scrollY: pixels + "px",
    scrollX: "100%",
    columns: columns["data"],
    aaData: data_source["data"],
    pageLength: page_length
  });
  return table;
}

export function setup_table(
  table_name,
  page_length,
  table_buttons,
  save_state
) {
  if (table_buttons == null) {
    table_buttons = this.default_table_buttons();
  }

  var stateSaving = true;
  if (save_state != null) {
    stateSaving = save_state;
  }
  var pixels = page_length * 37;
  var table = $(table_name).DataTable({
    lengthChange: false,
    dom: "Bfrtip",
    select: true,
    scrollY: pixels + "px",
    scrollX: "100%",
    pageLength: page_length,
    stateSave: stateSaving,
    buttons: table_buttons
  });
  $($.fn.dataTable.tables(true)).css("width", "100%");
  $($.fn.dataTable.tables(true))
    .DataTable()
    .columns.adjust()
    .draw();
  if (stateSaving == true) {
    this.tableStateSaving(table);
  }
}

export function default_table_buttons() {
  return [this.copy_button(), this.copy_selected_button()];
}

export function copy_button() {
  return {
    extend: "copy",
    text: "Copy",
    exportOptions: {
      columns: ":visible"
    }
  };
}

export function copy_selected_button() {
  return {
    extend: "copy",
    text: "Copy Selected",
    exportOptions: {
      columns: ":visible",
      modifier: {
        selected: true
      }
    }
  };
}

export function setup_tab_change_redraw() {
  $('a[data-toggle="tab"]').on("shown.bs.tab", function(e) {
    $($.fn.dataTable.tables(true)).css("width", "100%");
    $($.fn.dataTable.tables(true))
      .DataTable()
      .columns.adjust()
      .draw();
  });
}

export function add_search_to_table(table_name) {
  $(table_name + " tfoot th").each(function() {
    var title = $(this).text();
    $(this).html(
      '<input type="text" class="form-control" placeholder="Search ' +
        title +
        '" />'
    );
  });
}

/** This configures datatables search for 'table_name'. */
export function setup_search_for_table(table_name) {
  // Apply the search
  $(table_name)
    .DataTable()
    .columns()
    .every(function() {
      var that = this;

      $("input", this.footer()).on("keyup change", function() {
        if (that.search() !== this.value) {
          that.search(this.value).draw();
        }
      });
    });
}

export function tableStateSaving(table) {
  var state = table.state.loaded();
  if (state) {
    table
      .columns()
      .eq(0)
      .each(function(colIdx) {
        var colSearch = state.columns[colIdx].search;
        if (colSearch.search) {
          $("input", table.column(colIdx).footer()).val(colSearch.search);
        }
      });
    table.draw();
  }
  // Apply the search
  table
    .columns()
    .eq(0)
    .each(function(colIdx) {
      $("input", table.column(colIdx).footer()).on("keyup change", function() {
        table
          .column(colIdx)
          .search(this.value)
          .draw();
      });
    });
}
