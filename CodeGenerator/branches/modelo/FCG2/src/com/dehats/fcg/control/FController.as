package com.dehats.fcg.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import com.dehats.fcg.command.*;
	
	import com.dehats.fcg.events.*;
	
	public class FController extends FrontController
	{
		
		public static const START_UP:String="startUp";
		public static const NEW_PROJECT:String="newProject";
		
		public function FController()
		{
			addCommand(START_UP, StartUpCommand);			
			addCommand(ProjectEvent.EVENT_PROJECT_START, StartProjectCommand);		
			addCommand(NEW_PROJECT, NewProjectCommand);
			
			addCommand(OpenOpeDialogEvent.EVENT_OPENOPEDIALOG, OpenOpeDialogCommand);
		
			addCommand(FileSelectionEvent.EVENT_FILESELECTION, SelectFilesCommand);			
			addCommand(CreateFileListUIEvent.EVENT_CREATEFILELISTUI, CreateFileListUICommand);
			addCommand(CreateFileListEvent.EVENT_CREATE_LIST, CreateFileListCommand);			
			addCommand(DragFileEvent.EVENT_START_DRAG_OUT, DragFileOutCommand);			
			addCommand(FileDeletionEvent.EVENT_FILEDELETION, DeleteFilesCommand);
		}
		
	}
}