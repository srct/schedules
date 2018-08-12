/**
 * util/utilities.ts
 *
 * Reusable deterministic functions.
 */
import * as FileSaver from 'file-saver';

export const downloadFile = (text: string, fileName: string) =>
    FileSaver.saveAs(new Blob([text], { type: 'text/plain;charset=utf-8' }), fileName);
